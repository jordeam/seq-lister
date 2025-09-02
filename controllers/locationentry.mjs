import { seqlz } from '../db.mjs';
import { QueryTypes } from 'sequelize';
import Location from "../models/location.mjs";
import LocationEntry from "../models/locationentry.mjs";
import Component from "../models/component.mjs";
import Case from "../models/case.mjs";
import asyncHandler from "express-async-handler";
import Group from '../models/group.mjs';
import SuperGroup from '../models/supergroup.mjs';

const controller = {};

// Edit a location entry
// need to pass locationentry, component, and location
controller.home = asyncHandler(async (req, res, next) => {
  const locationEntry = await LocationEntry.findOne({ where: { id: req.params.id } });

  if (locationEntry === null) {
    // No results.
    const err = new Error("Entrada na Localização não encontrada.");
    err.status = 404;
    return next(err);
  }

  const [component, location] =
    await Promise.all(
      [Component.findOne({ where: { id: locationEntry.component_id }}),
      Location.findOne({ where: { id: locationEntry.location_id } })]);

  const ccase = await Case.findOne({ where: { id: component.case_id }});
  const group = await Group.findOne({ where: { id: component.group_id }});

  const from_table = /table$/.test(req.originalUrl);

  res.render("locationentry_home", {
    user: req.user,
    locationentry: locationEntry,
    location,
    component,
    ccase,
    group,
    from_table,
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
  locationEntry.labels = req.body.labels;
  await locationEntry.save();

  const retURL = "/location/" + locationEntry.location_id + (/table$/.test(req.originalUrl) ? "/table" : "");
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
  if (/table$/.test(req.originalUrl))
      res.redirect('/location/' + id + "/table");
  else
      res.redirect('/location/' + id.toString());
});

// Insert a new location_entry, i.e., a new component in a location
controller.choose = asyncHandler(async (req, res, next) => {
  const default_supergroup = 1;
  const default_group = 6;

  const [location, allSuperGroups, allGroups, allComponents, allCases] =
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
        ]);

  const usingTable = /table$/.test(req.originalUrl) ? true : false;
  res.render('locationentry_choose', {
    user: req.user,
    location,
    supergroups: allSuperGroups,
    groups: allGroups,
    default_supergroup,
    default_group,
    components: allComponents,
    usingTable,
    allCases,
  });
});

controller.insert = asyncHandler(async (req, res, next) => {
  const location_id = (undefined === req.body.location_id) ? req.params.id : req.body.location_id;
  const supcode_id = +req.body.supcode_id;

  const locationEntry = await LocationEntry.create({
    location_id: location_id,
    supcode_id: supcode_id,
    quant: req.body.quant,
    quant_unit: req.body.quant_unit,
    box: req.body.box,
    labels: req.body.labels,
  });
  if (/table$/.test(req.originalUrl))
    res.redirect("/location/" + location_id +"/table");
  else
    res.redirect("/location/" + location_id);
});

controller.createComp = asyncHandler(async (req, res, next) => {
  const uTable = /table$/.test(req.originalUrl) ? '/table' : '';
  const component = await Component.create({group_id: req.body.group_id, name: req.body.compname, case_id: req.body.case_id});

  let box = parseInt(req.body.box);
  let quant = parseInt(req.body.quant);
  let quant_unit = parseInt(req.body.quant_unit);
  let labels = req.body.labels.trim();

  console.log(`box=${box}`);
  console.log(`quant_unit=${quant_unit}`);
  console.log(`quant=${quant}`);
  console.log(`labels=${labels}`);

  await LocationEntry.create({ location_id: req.params.id, component_id: component.getDataValue('id'), quant: quant, quant_unit: quant_unit, box: box, labels: labels });

  res.redirect('/location/' + req.params.id + uTable);
});

export default controller;
