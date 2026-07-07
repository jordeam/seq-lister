import { seqlz } from '../db.mjs';
import { QueryTypes } from 'sequelize';
import Location from "../models/location.mjs";
import Case from '../models/case.mjs';
import Group from '../models/group.mjs';
import Component from "../models/component.mjs";
import Suppliercode from "../models/suppliercode.mjs";
import asyncHandler from "express-async-handler";
import Manufact from '../models/manufacturer.mjs';
import Supplier from '../models/supplier.mjs';
import LocationEntry from '../models/locationentry.mjs';

const controller = {};

// Show component data
controller.home = asyncHandler(async (req, res, next) => {
  // Get details of supergroup and all associated pets (in parallel)
  const comp = await Component.findOne({ where: { id: req.params.id } });

  if (comp === null) {
    // No results.
    const err = new Error("Componente não encontrado.");
    err.status = 404;
    return next(err);
  }

  const [group, ccase] =
    await Promise.all([
      Group.findOne({ where: { id: comp.group_id } }),
      Case.findOne({ where: { id: comp.case_id } }),
      ]);
  const [allLocations, allCases, allGroups] =
    await Promise.all([
      Location.findAll({ order: [['name']] }),
      Case.findAll({ order: [['name']] }),
      Group.findAll({ where: {supergroup_id: group.supergroup_id}, order: [['name']] }),
    ]);

  const suppliercodes = await seqlz.query("select sc.id, s.name as s_name, ordercode, rounding, partnumber, m.name as m_name from suppliercodes as sc, suppliers as s, manufacturers as m where supplier_id = s.id and manufact_id=m.id and component_id = $1 ORDER BY sc.partnumber",
    {
      bind: [comp.id],
      type: QueryTypes.SELECT
    });

  for (const i in suppliercodes) {
    const locs = await seqlz.query("SELECT l.id, l.name, le.box FROM location_entry AS le INNER JOIN locations AS l ON l.id = le.location_id INNER JOIN suppliercodes AS sc ON sc.id = le.supcode_id WHERE sc.id = $1 ORDER BY l.name", {
      bind: [suppliercodes[i].id],
      type: QueryTypes.SELECT
    });
    suppliercodes[i].locs = locs;
  }

  const locations = await seqlz.query("SELECT l.id, l.name, le.box FROM location_entry AS le INNER JOIN locations AS l ON l.id = le.location_id INNER JOIN suppliercodes AS sc ON sc.id = le.supcode_id WHERE sc.component_id = $1 ORDER BY l.name",
    {
      bind: [comp.id],
      type: QueryTypes.SELECT,
    }); // await Location.findAll({ where: { id: { [Op.in]: locList } } });

  res.render("component_home", {
    user: req.user,
    component: comp,
    group,
    ccase,
    locations,
    allCases,
    allLocations,
    allGroups,
    suppliercodes,
  });
});

// Paramameters:
// :id is the id of component, receives case_id and name in body
controller.update = asyncHandler(async (req, res, next) => {
    await Component.update({name: req.body.name.trim(), case_id: req.body.case_id, group_id: req.body.group_id}, {where: {id: req.params.id}});

    res.redirect('/component/'+req.params.id.toString());
});

// Paramameters:
// :id is the id of group
controller.select = asyncHandler(async (req, res, next) => {
  const allComponents = await seqlz.query(
    "SELECT c.id, c.name, cs.name AS csname FROM components AS c, cases AS cs WHERE group_id = $1 AND cs.id = case_id ORDER BY c.name, cs.name",
    {
      bind: [req.params.id],
      type: QueryTypes.SELECT,
    }
  );

  res.render('component_select', {
    user: req.user,
    components: allComponents
  });
});

// Paramameters:
// id: is the id of group
controller.create = asyncHandler(async (req, res, next) => {
    const component = await Component.create({group_id: req.params.id, name: req.body.name.trim(), case_id: 0});
    res.redirect('/component/'+component.id);
});

// Paramameters:
// id: is the id of component
controller.delete = asyncHandler(async (req, res, next) => {
  const comp = await Component.findOne({where: {id: req.params.id}});
  const group_id = comp.group_id;
  // must destroy all location entries
  // await LocationEntry.destroy({where: {component_id: comp.id}});
  await comp.destroy();
  res.redirect('/group/' + group_id.toString());
});

// return all partnumbers of this component in JSON
controller.optcomp = asyncHandler(async (req, res, next) => {
  // A User can have many Posts
  const le_id = +req.params.id;
  console.log(`le_id=${le_id}`);
  const le = await LocationEntry.findOne({where: {id: le_id}});
  const partnumber = await Suppliercode.findOne({where: {id: le.supcode_id}});
  const comp_id = partnumber.component_id;
  Component.belongsTo(Case, {foreignKey: 'case_id'});
  Component.belongsTo(Group, {foreignKey: 'group_id'});
  const comp = await Component.findOne({where: {id: comp_id}, include: [Case, Group]});

  Suppliercode.belongsTo(Manufact, { foreignKey: 'manufact_id' });
  Suppliercode.belongsTo(Supplier, { foreignKey: 'supplier_id' });
  const partnumbers = await Suppliercode.findAll({ where: { component_id: comp_id }, include: [Manufact, Supplier]});
  if (partnumbers === null) {
    // No results.
    const err = new Error("Component Id not found.");
    err.status = 404;
    return next(err);
  }
  res.json({ status: 0, le, component: comp, partnumbers, });
});

export default controller;
