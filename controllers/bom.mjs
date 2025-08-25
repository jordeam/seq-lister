import { seqlz } from '../db.mjs';
import { QueryTypes, Op} from 'sequelize';
import Location from "../models/location.mjs";
import LocationEntry from "../models/locationentry.mjs";
import Component from "../models/component.mjs";
import Case from "../models/case.mjs";
import Group from "../models/group.mjs";
import asyncHandler from "express-async-handler";
import Suppliercode from '../models/suppliercode.mjs';
import Supplier from '../models/supplier.mjs';
import Manufacturer from '../models/manufacturer.mjs';

const controller = {};

// Redirect to list of Locations
controller.list = asyncHandler(async (req, res, next) => {
  res.redirect("/location");
});

// Main page for BOM manipulating
controller.home = asyncHandler(async (req, res, next) => {
  // Get details of supergroup and all associated pets (in parallel)
  const [entries, loc, allLocations] =
        await Promise.all([
          seqlz.query("SELECT location_entry.id, components.name AS cname,groups.name AS gname, component_id, quant, quant_unit, box,labels, cs.name AS csname FROM location_entry, components, groups, cases AS cs WHERE component_id = components.id AND group_id = groups.id AND case_id = cs.id AND location_id = ? ORDER BY groups.name, components.name", {
            replacements: [req.params.id],
            type: QueryTypes.SELECT
          }),
          Location.findOne({where: {id: req.params.id}}),
          Location.findAll(),
        ]);
  if (loc === null) {
    // No results.
    const err = new Error("Localização não encontrada");
    err.status = 404;
    return next(err);
  }

  const bom_lst = loc.get('bom').split(/\r?\n/);

  console.log(`Header=${bom_lst[0]}`);
  const header = bom_lst[0].split(/ *, */);
  let qty, ref, pn, value, ordercode;
  for (const i in header) {
    if (/Qty/i.test(header[i]))
      qty = +i;
    else if (/Reference/i.test(header[i]))
      ref = +i;
    else if (/(Part *Number)|(mfg#)/i.test(header[i]))
      pn = +i;
    else if (/Value/i.test(header[i]))
     value = +i;
    else if (/Mouser/i.test(header[i]))
     ordercode = +i;
  }

  console.log(`qty=${qty} ref=${ref} pn=${pn} value=${value} ordercode=${ordercode}`);

  let bom = [];

  const regex = /,(?=(?:(?:[^"]*"){2})*[^"]*$)/;

  for (const line of bom_lst.slice(1)) {
    const lst = line.split(regex);
    //console.log(`lst[0]=${lst[0]} line=${line}`);
    if (lst.length > 6) {
      let entry = {};
      entry.status = lst[0];
      entry.compId = lst[1];
      entry.leId = lst[2];
      if (qty)
        entry.qty = lst[qty] === undefined ? 0 : parseInt(lst[qty].replace(/\"/g, ''));
      if (ref)
        entry.ref = lst[ref].replace(/\"/g, '');
      if (pn)
        entry.pn = lst[pn].replace(/\"/g, '');
      if (value)
        entry.value = lst[value].replace(/\"/g, '');
      if (ordercode)
        entry.ordercode = lst[ordercode] ? lst[ordercode].replace(/\"/g, '') : "";
      console.log("entry=%j", entry);
      bom.push(entry);
    }
  }

  res.render("bom_home", {
    user: req.user,
    location: loc,
    entries,
    allLocations,
    usingTable: /table$/.test(req.originalUrl),
    bom,
  });
});


controller.upload = asyncHandler(async (req, res) => {
  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).send('No files were uploaded.');
  }

  let loc = await Location.findOne({where: {id: req.params.id}});

  // console.log("req.files=%j", req.files);

  let data = req.files.file1.data.toString();

  let lst = data.split(/\r?\n/);
  let str;

  if (lst.length > 0) {
    str = "status,compId,leId," + lst[0].trim() + '\n';
    for (const line of lst.splice(1)) {
      if (line.length > 2)
        str += 'u,0,0,' + line.trim() + '\n';
    }
  }

  // console.log(`str=${str}`);
  loc.setDataValue('bom', str);

  loc.save();

  res.redirect("/bom/" + loc.id);
});


controller.query = asyncHandler(async (req, res) => {
  const locId = +req.params.id;
  const index = +req.query.line;
  // get location
  const loc = await Location.findOne({where: {id: locId}});
  const suppliers = await Supplier.findAll();
  const sup = await Supplier.findOne({where: {name: {[Op.regexp]: 'Mouser'}}});
  const manufacts = await Manufacturer.findAll();

  const bom_lst = loc.bom.split(/\r?\n/);

  const header = bom_lst[0].split(/ *, */);
  let qty, labels, pn, value, order;
  for (const i in header) {
    if (/Qty/i.test(header[i]))
      qty = +i;
    else if (/Reference/i.test(header[i]))
      labels = +i;
    else if (/(Part *Number)|(mfg#)/i.test(header[i]))
      pn = +i;
    else if (/Value/i.test(header[i]))
     value = +i;
    else if (/Mouser/i.test(header[i]))
     order = +i;
  }

  // console.log(`qty=${qty} ref=${ref} pn=${pn} value=${value} order=${order}`);

  const regex = /,(?=(?:(?:[^"]*"){2})*[^"]*$)/;

  const line = bom_lst[index + 1];
  const lst = line.split(regex);
  console.log(`line=${line}`);
  let entry = {};
  if (lst.length > 6) {
    entry.status = lst[0];
    entry.compId = lst[1];
    entry.leId = lst[2];
    if (qty)
      entry.qty = lst[qty] === undefined ? 0 : parseInt(lst[qty].replace(/\"/g, ''));
    else
      entry.qty = 0;
    if (value)
      entry.value = lst[value].replace(/\"/g, '');
    else
      entry.value = "";
    if (pn)
      entry.pn = lst[pn].replace(/\"/g, '');
    else
      entry.pn = "";
    if (order)
      entry.ordercode = lst[order] ? lst[order].replace(/\"/g, '') : "";
    else
      entry.ordercode = "";
    if (labels)
      entry.labels = lst[labels].replace(/\"/g, '');
    else
      entry.labels = "";
  }

  let sc, comp, group, ccase;

  if (entry.pn.length > 1)
    sc = await Suppliercode.findOne({where: {partnumber: entry.pn}});
  if (sc)
    comp = await Component.findOne({where: {id: sc.component_id}});
  if (comp)
    group = await Group.findOne({where: {id: comp.group_id}});
  if (comp)
    ccase = await Case.findOne({where: {id: comp.case_id}});

  if (sc)
    res.render("bom_by_partnumber", {
      loc,
      entry,
      index,
      sc,
      ccase,
      comp,
      group,
      suppliers,
      supplier_default_id: sup.id,
      manufacts,
    });
  else
    res.send("<h3> Partnumber not found: click create Component");
});

controller.insert = asyncHandler(async (req, res) => {
  // Find Mouser supplier ID
  console.log(req.body);

  const component_id = req.body.comp_id;

  const locEntry = await LocationEntry.create({
    location_id: req.params.id,
    labels: req.body.labels,
    component_id: component_id,
    quant_unit: req.body.qty,
  });

  await Suppliercode.update({
    ordercode: req.body.ordercode,
    rounding: req.body.rounding,
    manufact_id: req.body.manufact_id,
    active: req.body.active,
    supplier_id: req.body.supplier_id,
  }, {
    where: {id: req.body.sc_id}
  });

  // will set all other suppliercodes active flags to false
  if (req.body.active)
    await seqlz.query("UPDATE suppliercodes SET active = false WHERE component_id = $1 AND id <> $2",
                      {
                        bind: [component_id, supCode.id],
                        type: QueryTypes.UPDATE,
                      });
  res.send("<p>Componente inserido!\n<hr>");
});

export default controller;
