import { seqlz } from '../db.mjs';
import { QueryTypes } from 'sequelize';
import Location from "../models/location.mjs";
import LocationEntry from "../models/locationentry.mjs";
import Component from "../models/component.mjs";
import Case from "../models/case.mjs";
import asyncHandler from "express-async-handler";
import Group from '../models/group.mjs';
import SuperGroup from '../models/supergroup.mjs';
import Manufacturer from '../models/manufacturer.mjs';
import Supplier from '../models/supplier.mjs';
import Suppliercode from '../models/suppliercode.mjs';

const controller = {};

// Edit a location entry
// need to pass locationentry, component, and location
controller.home = asyncHandler(async (req, res, next) => {
  const le = await LocationEntry.findOne({ where: { id: req.params.id } });
  if (le === null) {
    // No results.
    const err = new Error("Entrada na Localização não encontrada.");
    err.status = 404;
    return next(err);
  }
  const [sc, location] =
    await Promise.all([
      Suppliercode.findOne({ where: { id: le.supcode_id }}),
      Location.findOne({ where: { id: le.location_id } })
    ]);
  const comp = await Component.findOne({where: {id: sc.component_id}});
  const [ccase, group] = await Promise.all([
    Case.findOne({ where: { id: comp.case_id }}),
    Group.findOne({ where: { id: comp.group_id }}),
  ]);
  res.render("locationentry_home", {
    user: req.user,
    locationentry: le,
    location,
    component: comp,
    ccase,
    group,
  });
});

controller.update = asyncHandler(async (req, res, next) => {
  const locationEntry = await LocationEntry.findOne({ where: { id: req.params.id } });
  if (locationEntry === null) {
    // No results.
    const err = new Error("Entrada na Localização não encontrada.");
    err.status = 404;
    return next(err);
  }
  locationEntry.box = req.body.box;
  locationEntry.quant = req.body.quant;
  locationEntry.quant_unit = req.body.quant_unit;
  locationEntry.labels = req.body.labels.trim();
  locationEntry.sent = req.body.sent;
  await locationEntry.save();
  const retURL = "/location/" + locationEntry.location_id;
  res.redirect(retURL);
});

controller.delete = asyncHandler(async (req, res, next) => {
  const locationEntry = await LocationEntry.findOne({ where: { id: req.params.id } });
  if (locationEntry === null) {
    // No results.
    const err = new Error("Entrada na Localização não encontrada.");
    err.status = 404;
    return next(err);
  }
  const id = locationEntry.location_id;
  await locationEntry.destroy();
  await locationEntry.destroy();
  res.redirect('/location/' + id.toString());
});

// Insert a new location_entry, i.e., a new component in a location
controller.choose = asyncHandler(async (req, res, next) => {
  const default_supergroup = 1;
  const default_group = 6;

  const [location, allSuperGroups, allGroups, allComponents, allCases, allManufacts, allSuppliers] =
        await Promise.all([
          Location.findOne({ where: { id: req.params.location_id } }),
          SuperGroup.findAll({ order: [['name']] }),
          Group.findAll({ where: { supergroup_id: default_supergroup }, order: [['name']] }),
          seqlz.query("SELECT c.id, c.name, cs.name AS csname FROM components AS c, cases AS cs WHERE group_id = $1 AND cs.id = case_id ORDER BY c.name, cs.name",
                      {
                        bind: [default_group],
                        type: QueryTypes.SELECT,
                      }
                     ),
          Case.findAll({ order: [['name']]}),
          Manufacturer.findAll({order: [['name']]}),
          Supplier.findAll({order: [['name']]}),
        ]);

  res.render('locationentry_choose', {
    user: req.user,
    location,
    supergroups: allSuperGroups,
    groups: allGroups,
    default_supergroup,
    default_group,
    components: allComponents,
    allCases,
    allManufacts,
    allSuppliers,
  });
});

controller.insert = asyncHandler(async (req, res, next) => {
  const location_id = (undefined === req.body.location_id) ? req.params.id : req.body.location_id;
  const supcode_id = +req.body.supcode_id;

  // console.log(`box=${req.body.box} quant=${req.body.quant} quant_unit=${req.body.quant_unit} labels=${req.body.labels}`);
  let box = parseInt(req.body.box);
  let quant = parseInt(req.body.quant);
  let quant_unit = parseInt(req.body.quantunit);
  let labels = req.body.labels.trim();

  const locationEntry = await LocationEntry.create({
    location_id: location_id,
    supcode_id: supcode_id,
    quant,
    quant_unit,
    box,
    labels,
  });
  res.redirect("/location/" + location_id);
});

/**
 * Create a new component with name given by form, setting partnumber,
 * ordercode, etc. given by form.
 */
controller.insertNewComp = asyncHandler(async (req, res, next) => {
  const component = await Component.create({group_id: req.body.group_id, name: req.body.compname.trim(), case_id: req.body.case_id});
  const sc = await Suppliercode.create({
    component_id: component.id,
    partnumber: req.body.partnumber.trim(),
    ordercode: req.body.ordercode.trim(),
    manufact_id: req.body.manufact,
    supplier_id: req.body.supplier,
    descr: req.body.descr.trim(),
    rounding: req.body.rounding,
  });
  let box = parseInt(req.body.box);
  let quant = parseInt(req.body.quant);
  let quant_unit = parseInt(req.body.quantunit);
  let labels = req.body.labels.trim();
  await LocationEntry.create({
    location_id: req.params.id,
    supcode_id: sc.id,
    quant,
    quant_unit,
    box,
    labels,
  });
  res.redirect('/location/' + req.params.id);
});

controller.sent = asyncHandler(async (req, res, next) => {
  const locationEntry = await LocationEntry.findOne({ where: { id: req.params.id } });
  if (locationEntry === null) {
    // No results.
    const err = new Error("Entrada na Localização não encontrada.");
    err.status = 404;
    return next(err);
  }
  const sent = +req.body.sent.trim();
  locationEntry.sent = sent;
  await locationEntry.save();
  res.json({status: 0, sent,});
});

export default controller;
