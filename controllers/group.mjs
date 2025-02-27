import { seqlz } from '../db.mjs';
import { QueryTypes } from 'sequelize';
import Group from "../models/group.mjs";
import SuperGroup from "../models/supergroup.mjs";

import asyncHandler from "express-async-handler";

const controller = {};

// List components of a specific group
controller.home = asyncHandler(async (req, res, next) => {
  // Get details of supergroup and all associated pets (in parallel)
  const allComponents = await seqlz.query(
    "SELECT c.id, c.name, cs.name AS csname FROM components AS c, cases AS cs WHERE group_id = $1 AND cs.id = case_id ORDER BY c.name, cs.name",
    {
      bind: [req.params.id],
      type: QueryTypes.SELECT,
    }
  );

  const group = await Group.findOne({ where: { id: req.params.id } });

  if (group === null) {
    // No results.
    const err = new Error("Grupo não encontrado.");
    err.status = 404;
    return next(err);
  }

  const superGroup = await SuperGroup.findOne({ where: { id: group.supergroup_id } });

  res.render("group_home", {
    user: req.user,
    group,
    supergroup: superGroup,
    allComponents,
  });
});

// Paramameters:
// id: is the id of supergroup
controller.select = asyncHandler(async (req, res, next) => {
  const allGroups = await Group.findAll({ where: { supergroup_id: req.params.id }, order: [['name']] });

  res.render('group_select', {
    user: req.user,
    groups: allGroups
  });
});

// Create a new group with supergroup :id parameter
controller.create = asyncHandler(async (req, res, next) => {
  const grp = await Group.create({name: req.body.name, supergroup_id: req.params.id});

  return res.redirect(grp.url);
});

controller.delete = asyncHandler(async (req, res, next) => {
  const group = await Group.findOne({ where: { id: req.params.id } });

  if (group === null) {
    // No results.
    const err = new Error("Grupo não encontrado.");
    err.status = 404;
    return next(err);
  }

  const supergroup_id = group.supergroup_id;
  await group.destroy();
  res.redirect('/supergroup/'+supergroup_id);
});

// Paramameters:
// :id is the id of group, receives name in body
controller.update = asyncHandler(async (req, res, next) => {
    await Group.update({name: req.body.name}, {where: {id: req.params.id}});

    res.redirect('/group/'+req.params.id);
});

export default controller;
