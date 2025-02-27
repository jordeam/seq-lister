import { seqlz } from '../db.mjs';
import Case from "../models/case.mjs";

import asyncHandler from "express-async-handler";
import Component from '../models/component.mjs';

const controller = {};

// Display list of all Cases
controller.list = asyncHandler(async (req, res, next) => {
    const allCases = await Case.findAll({order: seqlz.col('name')});
    res.render("case_list", {
      user: req.user,
      cases_list: allCases,
    });
});

// Display detail page for a specific Case.
controller.home = asyncHandler(async (req, res, next) => {
  // Get details of case and all associated pets (in parallel)
  const ccase = await Case.findOne({where: {id: req.params.id}});
  if (ccase === null) {
    // No results.
    const err = new Error("Encapsulamento não encontrado");
    err.status = 404;
    return next(err);
  }

  // get all components using this case
  const components = await Component.findAll({where: {case_id: req.params.id}});

  res.render("case_home", {
    user: req.user,
    ccase,
    components,
  });
});

controller.update = asyncHandler(async (req, res, next) => {
  const ccase = await Case.findOne({where: {id: req.params.id}});

  ccase.name = req.body.name;
  ccase.descr = req.body.descr;

  await ccase.save();

  res.redirect('/case/');
});

// Show the page to insert a new case in DB
controller.create = asyncHandler(async (req, res, next) => {
  // Get details of case and all associated pets (in parallel)
  res.render("case_create", {
    user: req.user,
  });
});

// Insert a new case in DB
controller.create_post = asyncHandler(async (req, res, next) => {
  // Get details of case and all associated pets (in parallel)
  await Case.create({name: req.body.name, descr: req.body.descr});

  res.redirect("/case/");
});

// Display detail page for a specific Case.
controller.delete = asyncHandler(async (req, res, next) => {
  // Get details of case and all associated pets (in parallel)

  // get all components using this case
  const n = await Component.count({where: {case_id: req.params.id}});

  if (n === 0)
    await Case.destroy({where: {id: req.params.id}});

  res.redirect("/case");
});


export default controller;
