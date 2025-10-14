import { seqlz } from '../db.mjs';
import Supergroup from "../models/supergroup.mjs";
import Group from "../models/group.mjs";

import asyncHandler from "express-async-handler";

const controller = {};

// Display list of all Supergroup.
controller.index = asyncHandler(async (req, res, next) => {
    const allSupergroups = await Supergroup.findAll({attributes: ['id', 'name'], order: seqlz.col('name')});
    res.render("supergroup_list", {
      user: req.user,
      supergroups_list: allSupergroups,
    });
});

// Display detail page for a specific Supergroup.
controller.list = asyncHandler(async (req, res, next) => {
  // Get details of supergroup and all associated pets (in parallel)
  const [allGroups, supergroup] = await Promise.all([Group.findAll({where: {supergroup_id: req.params.id}, order: [['name']]}), Supergroup.findOne({where: {id: req.params.id}})]);
  if (allGroups === null || supergroup === null) {
    // No results.
    const err = new Error("Supergrupo não encontrado");
    err.status = 404;
    return next(err);
  }

  res.render("supergroup_home", {
    user: req.user,
    supergroup,
    allGroups,
  });
});

// Create a new supergroup
controller.create = asyncHandler(async (req, res, next) => {
  const spgrp = await Supergroup.create({name: req.body.name.trim()});

  return res.redirect(spgrp.url);
});

controller.delete = asyncHandler(async (req, res, next) => {
  const spgroup = await Supergroup.findOne({ where: { id: req.params.id } });

  if (spgroup === null) {
    // No results.
    const err = new Error("Supergrupo não encontrado.");
    err.status = 404;
    return next(err);
  }

  await spgroup.destroy();
  res.redirect('/supergroup');
});

export default controller;
