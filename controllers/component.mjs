import { seqlz } from '../db.mjs';
import { QueryTypes } from 'sequelize';
import Location from "../models/location.mjs";
import Case from '../models/case.mjs';
import Group from '../models/group.mjs';
import Component from "../models/component.mjs";
import LocationEntry from '../models/locationentry.mjs';

import asyncHandler from "express-async-handler";

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
    const locs = await seqlz.query("SELECT l.id, l.name FROM location_entry AS le INNER JOIN locations AS l ON l.id = le.location_id INNER JOIN suppliercodes AS sc ON sc.id = le.supcode_id WHERE sc.id = $1 ORDER BY l.name", {
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
    await Component.update({name: req.body.name, case_id: req.body.case_id, group_id: req.body.group_id}, {where: {id: req.params.id}});

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
    const component = await Component.create({group_id: req.params.id, name: req.body.name, case_id: 0});
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

export default controller;
