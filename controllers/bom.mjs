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
 * Return the id of str in name field. Return -1 if not found
 * lst must be in the form [{id: Number name: String}, ...]
 */
function findInList(str, lst) {
  let i = -1;
  for (const elt of lst) {
    console.log(`id=${elt.id} name=${elt.name} str=${str}`);
//    if (elt.name.trim().toLowerCase().search(str.trim().toLowerCase()) >= 0) {
//    if (elt.name.trim().toLowerCase().search(str.trim().toLowerCase()) >= 0) {
    const reg = new RegExp(`\\b${str}\\b`, 'ig');
    if (elt.name.match(reg)) {
      i = elt.id;
      break;
    }
  }
  console.log(`i=${i}`);
  return i;
}

/**
 * return all indexes of entries in str
 */
function makeEntryIndexes(headerStr, mfrList, supList) {
  const regex = /,(?=(?:(?:[^"]*"){2})*[^"]*$)/;
  const header = headerStr.split(regex);
  let qty, labels, pn, order, compname, descr, mfr, sup;
  console.log(`header=%j`, header);
  for (const i in header) {
    if (/Qty/i.test(header[i]))
      qty = +i;
    else if (/Reference/i.test(header[i]))
      labels = +i;
    else if (/(Part *Number)|(mfg#)|(mfr#)/i.test(header[i]))
      pn = +i;
    else if (/(mfg)|(mfr)|(Manufacturer)/i.test(header[i]))
      mfr = + i;
    else if (/(Vendor)|(Sup)|(Supplier)/i.test(header[i]))
      sup = + i;
    else if (/(oc)|(oc#)|(Order *Code)/i.test(header[i]))
     order = +i;
    else if (/Value/i.test(header[i]))
      compname = +i;
    else if (/Descr.*/i.test(header[i]))
      descr = +i;
  }
  console.log({qty, labels, pn, order, compname, descr, mfr, sup});
  return {qty, labels, pn, order, compname, descr, mfr, sup};
}

/**
 * Scan a line index+1 in BOM string to fill entry fields: qty, labels, pn,
 * order, compname, descr;
 */
function makeEntries(indx, entryLine, mfrList, supList) {
  const regex = /,(?=(?:(?:[^"]*"){2})*[^"]*$)/;
  const lst = entryLine.split(regex);
  console.log(`line=${entryLine}`);
  let entry = {};
  if (lst.length > 6) {
    entry.status = lst[0];
    entry.compId = lst[1];
    entry.leId = lst[2];
    if (indx.qty)
      entry.qty = lst[indx.qty] === undefined ? 0 : parseInt(lst[indx.qty].replace(/\"/g, ''));
    else
      entry.qty = 0;
    if (indx.pn)
      entry.pn = lst[indx.pn].replace(/\"/g, '').trim();
    else
      entry.pn = "";
    if (indx.order)
      entry.ordercode = lst[indx.order] ? lst[indx.order].replace(/\"/g, '').trim() : "";
    else
      entry.ordercode = "";
    if (indx.labels)
      entry.labels = lst[indx.labels].replace(/\"/g, '').trim();
    else
      entry.labels = "";
    if (indx.compname)
      entry.compname = lst[indx.compname].replace(/\"/g, '').trim();
    else
      entry.compname = "";
    if (indx.descr)
      entry.descr = lst[indx.descr].replace(/\"/g, '').trim();
    else
      entry.descr = "";
    if (indx.mfr && indx.mfr >= 0)
      // -1 if not found else id the manufacturer id
      entry.mfr = findInList(lst[indx.mfr].replace(/\"/g, '').trim(), mfrList);
    if (indx.sup && indx.sup >= 0)
      // -1 if not found else id the manufacturer id
      entry.sup = findInList(lst[indx.sup].replace(/\"/g, '').trim(), supList);
  }
  console.log(`compname=${entry.compname}\nentry=%j`, entry);
  return entry;
}

// Redirect to list of Locations
controller.list = asyncHandler(async (req, res, next) => {
  res.redirect("/location");
});

// Main page for BOM manipulating
controller.home = asyncHandler(async (req, res, next) => {
  const [entries, loc, allLocations, allSuppliers, allManufacturers] =
        await Promise.all([
          seqlz.query("SELECT le.id, c.name AS cname, g.name AS gname, sc.component_id, le.quant, le.quant_unit, le.box, le.labels, cs.name AS csname, le.supcode_id, sc.partnumber, sc.ordercode FROM location_entry AS le LEFT JOIN suppliercodes AS sc ON sc.id = le.supcode_id LEFT JOIN components AS c ON c.id = sc.component_id LEFT JOIN cases AS cs ON cs.id = c.case_id LEFT JOIN groups AS g ON g.id = c.group_id WHERE le.location_id = ? ORDER BY g.name, c.name", {
            replacements: [req.params.id],
            type: QueryTypes.SELECT
          }),
          Location.findOne({where: {id: req.params.id}}),
          Location.findAll({order: seqlz.col('name')}),
          Supplier.findAll({order: seqlz.col('name')}),
          Manufacturer.findAll({order: seqlz.col('name')}),
        ]);
  if (loc === null) {
    // No results.
    const err = new Error("Localização não encontrada");
    err.status = 404;
    return next(err);
  }
  const bom_lst = loc.get('bom').split(/\r?\n/);
  console.log(`Header=${bom_lst[0]}`);
  const indx = makeEntryIndexes(bom_lst[0], allManufacturers, allSuppliers);
  let bom = [];
  for (const line of bom_lst.slice(1)) {
    const entry = makeEntries(indx, line, allManufacturers, allSuppliers);
    bom.push(entry);
  }
  res.render("bom_home", {
    user: req.user,
    location: loc,
    entries,
    allLocations,
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
  const suppliers = await Supplier.findAll({order: seqlz.col('name')});
  const manufacts = await Manufacturer.findAll({order: seqlz.col('name')});

  const bom_lst = loc.get('bom').split(/\r?\n/);
  //  console.log(`Header=${bom_lst[0]}`);
  const indx = makeEntryIndexes(bom_lst[0], manufacts, suppliers);
  const entry = makeEntries(indx, bom_lst[index + 1], manufacts, suppliers);

  let sc, comp, group, ccase;

  if (entry.pn.length > 1)
    sc = await Suppliercode.findOne({where: {partnumber: {[Op.regexp]: `^ *${escapeStringRegexp(entry.pn)} *$`}}});
  if (sc)
    comp = await Component.findOne({where: {id: sc.component_id}});
  if (comp)
    group = await Group.findOne({where: {id: comp.group_id}});
  if (comp)
    ccase = await Case.findOne({where: {id: comp.case_id}});

  if (sc) {
    sc.ordercode = sc.ordercode.trim();
    sc.partnumber = sc.partnumber.trim();
    res.render("bom_by_partnumber", {
      loc,
      entry,
      index,
      sc,
      ccase,
      comp,
      group,
      suppliers,
      manufacts,
    });
  }
  else
    res.send("<h3> Partnumber não encontrado: use Criar Component");
});

controller.insert = asyncHandler(async (req, res) => {
  // Find Mouser supplier ID
  console.log(req.body);

  await LocationEntry.create({
    location_id: req.params.id,
    labels: req.body.labels.trim(),
//    component_id: component_id,
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
  console.log(`index=${index}`);
  // get location
  const [loc, suppliers, manufacts, allCases, groups, supergroups] =
        await Promise.all([
          Location.findOne({where: {id: locId}}),
          Supplier.findAll({order: seqlz.col('name')}),
          Manufacturer.findAll({order: seqlz.col('name')}),
          Case.findAll({order: seqlz.col('name')}),
          Group.findAll({order: seqlz.col('name')}),
          SuperGroup.findAll({order: seqlz.col('name')}),
        ]);

  const bom_lst = loc.get('bom').split(/\r?\n/);
  //  console.log(`Header=${bom_lst[0]}`);
  const indx = makeEntryIndexes(bom_lst[0], manufacts, suppliers);
  const entry = makeEntries(indx, bom_lst[index + 1], manufacts, suppliers);

  let sc_pn, sc_oc;
  if (entry.pn.length > 1)
    sc_pn = await Suppliercode.findOne({where: {partnumber: {[Op.regexp]: `^ *${escapeStringRegexp(entry.pn)} *$`}}});
  if (entry.ordercode.length > 1)
    sc_oc = await Suppliercode.findOne({where: {ordercode: {[Op.regexp]: `^ *${escapeStringRegexp(entry.ordercode)} *$`}}});
  let err_str = "";
  if (sc_pn) {
    err_str += "<p>Erro: Partnumber encontrado, use criar por Partnumber\n";
    console.log(sc_pn);
  }
  if (sc_oc)
    err_str += "<p>Erro: Ordercode encontrado, use criar por Ordercode\n";

  if (err_str.length > 0)
    return res.send(err_str);

  res.render("bom_create_comp", {
    loc,
    entry,
    index,
    suppliers,
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
      name: req.body.compname.trim(),
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
      descr:req.body.descr.trim(),
      ordercode,
      rounding: req.body.round,
    });
  // Finally, insert a location entry:
  console.log(`Finally, insert a location entry`);
  await LocationEntry.create({
    location_id: req.body.loc_id,
    labels: req.body.labels.trim(),
//    component_id: comp.id,
    supcode_id: supcode.id,
    quant_unit: req.body.qty,
    box: req.body.box,
  });

  res.send('<p> Componente inserido');
});

export default controller;
