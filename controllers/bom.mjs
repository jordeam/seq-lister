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
import SuperGroup from '../models/supergroup.mjs';
import escapeStringRegexp from 'escape-string-regexp';

const controller = {};

/**
 * Scan a line index+1 in BOM string to fill entry fields: qty, labels, pn,
 * order, compname, descr;
 */
function makeEntries(bom_str, index) {
  const regex = /,(?=(?:(?:[^"]*"){2})*[^"]*$)/;
  const bom_lst = bom_str.split(/\r?\n/);
  const header = bom_lst[0].split(regex);
  let qty, labels, pn, order, compname, descr;
  console.log(`header=%j`, header);
  for (const i in header) {
    if (/Qty/i.test(header[i]))
      qty = +i;
    else if (/Reference/i.test(header[i]))
      labels = +i;
    else if (/(Part *Number)|(mfg#)/i.test(header[i]))
      pn = +i;
    else if (/Mouser/i.test(header[i]))
     order = +i;
    else if (/Value/i.test(header[i]))
      compname = +i;
    else if (/Descr.*/i.test(header[i]))
      descr = +i;
  }

  // console.log(`qty=${qty} ref=${ref} pn=${pn} compname=${compname} order=${order}`);


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
    if (pn)
      entry.pn = lst[pn].replace(/\"/g, '').trim();
    else
      entry.pn = "";
    if (order)
      entry.ordercode = lst[order] ? lst[order].replace(/\"/g, '').trim() : "";
    else
      entry.ordercode = "";
    if (labels)
      entry.labels = lst[labels].replace(/\"/g, '').trim();
    else
      entry.labels = "";
    if (compname)
      entry.compname = lst[compname].replace(/\"/g, '').trim();
    else
      entry.compname = "";
    if (descr)
      entry.descr = lst[descr].replace(/\"/g, '').trim();
    else
      entry.descr = "";
  }
  console.log(`compname=${compname}\nentry=%j`, entry);
  return entry;
}

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
  let qty, ref, pn, compname, ordercode;
  for (const i in header) {
    if (/Qty/i.test(header[i]))
      qty = +i;
    else if (/Reference/i.test(header[i]))
      ref = +i;
    else if (/(Part *Number)|(mfg#)/i.test(header[i]))
      pn = +i;
    else if (/Value/i.test(header[i]))
     compname = +i;
    else if (/Mouser/i.test(header[i]))
     ordercode = +i;
  }

  console.log(`qty=${qty} ref=${ref} pn=${pn} compname=${compname} ordercode=${ordercode}`);

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
      if (compname)
        entry.compname = lst[compname].replace(/\"/g, '');
      if (ordercode)
        entry.ordercode = lst[ordercode] ? lst[ordercode].replace(/\"/g, '').trim() : "";
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

  const entry = makeEntries(loc.bom, index);

  let sc, comp, group, ccase;

  if (entry.pn.length > 1)
    sc = await Suppliercode.findOne({where: {partnumber: {[Op.regexp]: `^ *${escapeStringRegexp(entry.pn)} *$`}}});
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
    res.send("<h3> Partnumber não encontrado: use Criar Component");
});

controller.insert = asyncHandler(async (req, res) => {
  // Find Mouser supplier ID
  console.log(req.body);

  const component_id = req.body.comp_id;

  await LocationEntry.create({
    location_id: req.params.id,
    labels: req.body.labels,
    component_id: component_id,
    supcode_id: req.body.sc_id,
    quant_unit: req.body.qty,
  });

  await Suppliercode.update({
    ordercode: req.body.ordercode.trim(),
    rounding: req.body.rounding,
    manufact_id: req.body.manufact_id,
    supplier_id: req.body.supplier_id,
  }, {
    where: {id: req.body.sc_id}
  });
  res.send("<p>Componente inserido!\n<hr>");
});

//** Create component, references, partnumber, etc. and insert it into location.
controller.create = asyncHandler(async (req, res) => {
  const locId = +req.params.id;
  const index = +req.query.line;
  // get location
  const [loc, suppliers, sup, manufacts, allCases, groups, supergroups] =
        await Promise.all([
          Location.findOne({where: {id: locId}}),
          Supplier.findAll({order: seqlz.col('name')}),
          Supplier.findOne({where: {name: {[Op.regexp]: 'Mouser'}}}),
          Manufacturer.findAll({order: seqlz.col('name')}),
          Case.findAll({order: seqlz.col('name')}),
          Group.findAll({order: seqlz.col('name')}),
          SuperGroup.findAll({order: seqlz.col('name')}),
        ]);

  const entry = makeEntries(loc.bom, index);

  let sc_pn, sc_oc;
  if (entry.pn.length > 1)
    sc_pn = await Suppliercode.findOne({where: {partnumber: {[Op.regexp]: `^ *${escapeStringRegexp(entry.pn)} *$`}}});
  if (entry.ordercode.length > 1)
    sc_oc = await Suppliercode.findOne({where: {ordercode: {[Op.regexp]: `^ *${escapeStringRegexp(entry.ordercode)} *$`}}});
  let err_str = "";
  if (sc_pn)
    err_str += "<p>Erro: Partnumber encontrado, use criar por Partnumber\n";
  if (sc_oc)
    err_str += "<p>Erro: Ordercode encontrado, use criar por Ordercode\n";

  if (err_str.length > 0)
    return res.send(err_str);

  res.render("bom_create_comp", {
    loc,
    entry,
    index,
    suppliers,
    supplier_default_id: sup.id,
    manufacts,
    allCases,
    groups,
    supergroups,
  });
});

controller.insertComp = asyncHandler(async (req, res) => {
  const comp_id = req.body.comp_id;
  let comp;
  if (comp_id == 0) {
    // if component id is zero, let's create a new component with compname and group id;
    comp = await Component.create({
      name: req.body.compname,
      group_id: req.body.group_id,
      case_id: req.body.case_id,});
  }
  else {
    comp = await Component.findOne({where: {id: comp_id}});
  }
  // Here, component is defined
  // Now need to create a suppliercode and link it to this component
  const pn = req.body.pn.trim();
  const ordercode = req.body.ordercode.trim();
  let supcode;
  if (pn.length > 0 || ordercode.length > 0)
    supcode = await Suppliercode.create({
      supplier_id: req.body.supplier_id,
      component_id: comp.id,
      manufact_id: req.body.manufact_id,
      partnumber: pn,
      descr:req.body.descr,
      ordercode,
      rounding: req.body.round,
    });
  // Finally, insert a location entry:
  console.log(`Finally, insert a location entry`);
  await LocationEntry.create({
    location_id: req.body.loc_id,
    labels: req.body.labels,
    component_id: comp.id,
    supcode_id: supcode.id,
    quant_unit: req.body.qty,
    box: req.body.box,
  });

  res.send('<p> Componente inserido');
});

export default controller;
