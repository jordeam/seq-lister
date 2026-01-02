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

// import escapeStringRegexp from 'escape-string-regexp';
// because there is a bug in this function, using:
function escapeStringRegexp(string) {
  // $& means the whole matched string.
  return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

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

const fieldList = {
  qty: /Qty/i,
  ref: /Reference/i,
  pn: /(Part *Number)|(pn)|(mfg#)|(mfr#)/i,
  mfr: /(mfg)|(mfr)|(Manufacturer)/i,
  sup: /(Vendor)|(Sup)|(Supplier)/i,
  oc: /(oc)|(supplier#)|(oc#)|(Order *Code)/i,
  val: /Value/i,
  desc: /Descr.*/i,
  foot: /Foot.*/i,
};

fieldList['desc'] = /Desc.*/i;

/**
 * return all indexes of entries in str
 */
function makeEntryIndexes(headerStr, mfrList, supList) {
  const regex = /,(?=(?:(?:[^"]*"){2})*[^"]*$)/;
  const header = headerStr.split(regex);
  let qty, labels, pn, order, compname, descr, mfr, sup, foot;
  console.log(`header=%j`, header);
  for (const i in header) {
    if (fieldList['qty'].test(header[i]))
      qty = +i;
    else if (fieldList['ref'].test(header[i]))
      labels = +i;
    else if (fieldList['pn'].test(header[i]))
      pn = +i;
    else if (fieldList['mfr'].test(header[i]))
      mfr = +i;
    else if (fieldList['sup'].test(header[i]))
      sup = +i;
    else if (fieldList['oc'].test(header[i]))
     order = +i;
    else if (fieldList['val'].test(header[i]))
      compname = +i;
    else if (fieldList['desc'].test(header[i]))
      descr = +i;
    else if (fieldList['foot'].test(header[i]))
      foot = +i;
  }
  console.log({qty, labels, pn, order, compname, descr, mfr, sup, foot});
  return {qty, labels, pn, order, compname, descr, mfr, sup, foot};
}

/**
 * Scan a line index+1 in BOM string to fill entry fields: qty, labels, pn,
 * order, compname, descr;
 */
function makeEntries(indx, entryLine, mfrList, supList) {
  const regex = /,(?=(?:(?:[^"]*"){2})*[^"]*$)/;
  const lst = entryLine.split(regex);
  // console.log(`line=${entryLine}`);
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
    if (indx.foot && indx.foot >= 0) {
      // -1 if not found else id the manufacturer id
      entry.foot = lst[indx.foot].replace(/\"/g, '').trim();
    }
  }
  // console.log(`compname=${entry.compname}\nentry=%j`, entry);
  return entry;
}

// Change the status of a BOM line to new_status
async function changeStatus(location_id, line, new_status) {
  const loc = await Location.findOne({ where: { id: location_id } });
  const bom_lst = loc.get('bom').split(/\r?\n/);
  let status;
  line++;
  if (line <= bom_lst.length) {
    const regex = /,(?=(?:(?:[^"]*"){2})*[^"]*$)/;
    const lst = bom_lst[line].split(regex);
    status = new_status;
    lst[0] = status;
    bom_lst[line] = lst.join(',');
    console.log(`bom_lst[${line}]=${bom_lst[line]}`);
    loc.set('bom', bom_lst.join('\n'));
    await loc.save();
  }
  return status;
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

/**
 * Upload the BOM from schematic
 */
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

// search by partnumber
controller.search_pn = asyncHandler(async (req, res) => {
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

  let partnumbers;

  console.log(`entry.pn=${entry.pn}`);
  if (entry.pn.length > 1)
      partnumbers = await seqlz.query("SELECT c.id AS comp_id, c.name AS comp_name, cs.name AS case_name, g.name AS g_name, sc.partnumber, sc.ordercode, s.name AS s_name, m.name AS m_name, sc.id AS sc_id FROM suppliercodes AS sc, components AS c, groups AS g, suppliers AS s, manufacturers AS m, cases as cs WHERE manufact_id = m.id AND supplier_id = s.id AND component_id = c.id AND group_id = g.id AND cs.id = c.case_id AND (partnumber ~* $1 OR ordercode ~* $1)",
                                    {
                                      bind: [entry.pn],
                                      type: QueryTypes.SELECT,
                                    });
  if (partnumbers && partnumbers.length > 0) {
    res.render("bom_by_partnumber", {
      loc,
      entry,
      index,
      partnumbers,
      suppliers,
      manufacts,
    });
  }
  else
    res.send("<h3> Partnumber não encontrado: use Criar Component");
});

// insert component using the same partnumber
controller.insert_pn = asyncHandler(async (req, res) => {
  const location_id = +req.params.id;
  await LocationEntry.create({
    location_id,
    labels: req.body.labels.trim(),
    supcode_id: +req.body.sc_id,
    quant_unit: +req.body.qty,
  });
  changeStatus(location_id, +req.body.index, 'i');
  res.send("i,<p>Componente inserido!\n<hr>");
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
  let att_str = [];
  if (sc_pn) {
    att_str.push(`Partnumber encontrado, considere criar por Partnumber (= PN: ${sc_pn.partnumber})`);
    console.log(sc_pn);
  }
  if (sc_oc)
    att_str.push(`Ordercode encontrado, considere criar por Partnumber (= PN: ${sc_oc.ordercode}) `);

  res.render("bom_create_comp", {
    att_str,
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

//** Create component, references, partnumber, etc. and insert it into location.
controller.insertExistingPN = asyncHandler(async (req, res) => {
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
  let att_str = [];
  if (sc_pn) {
    att_str.push(`Partnumber encontrado, considere criar por Partnumber (= PN: ${sc_pn.partnumber})`);
    console.log(sc_pn);
  }
  if (sc_oc)
    att_str.push(`Ordercode encontrado, considere criar por Partnumber (= PN: ${sc_oc.ordercode}) `);

  res.render("bom_insert_exist_pn", {
    att_str,
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
  supcode = await Suppliercode.create({
    supplier_id: req.body.supplier_id,
    component_id: comp.id,
    manufact_id: req.body.manufact_id,
    partnumber: pn,
    descr: req.body.descr.trim(),
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
  res.send('i,<p> Componente inserido');
});

/**
 * Finally insert a new location entry with an existing partnumer
 */
controller.insertCompWithPN = asyncHandler(async (req, res) => {
  const location_id = +req.body.loc_id;
  await LocationEntry.create({
    location_id,
    labels: req.body.labels.trim(),
//    component_id: comp.id,
    supcode_id: req.params.id,
    quant_unit: req.body.qty,
    box: req.body.box,
  });
  changeStatus(location_id, +req.body.index, 'i');
  res.send("i,<p>Componente inserido!\n<hr>");
});

// Change the status char of a line in location
controller.changeStatus = asyncHandler(async (req, res) => {
  let location_id = +req.params.id;
  let n = +req.query.line + 1;
  console.log(`location_id = ${location_id}, line number = ${n}`);
  const loc = await Location.findOne({ where: { id: location_id } });
  const bom_lst = loc.get('bom').split(/\r?\n/);
  let status;
  if (n <= bom_lst.length) {
    const regex = /,(?=(?:(?:[^"]*"){2})*[^"]*$)/;
    const lst = bom_lst[n].split(regex);
    if (lst[0] == 'i')
      lst[0] = 'u';
    else
      lst[0] = 'i';
    status = lst[0];
    bom_lst[n] = lst.join(',');
    console.log(`bom_lst[${n}]=${bom_lst[n]}`);
    loc.set('bom', bom_lst.join('\n'));
    await loc.save();
  }
  res.send(status);
});

export default controller;
