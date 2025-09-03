import { seqlz } from '../db.mjs';
import Manufacturer from "../models/manufacturer.mjs";

import asyncHandler from "express-async-handler";
// const { param } = require('../app');

const controller = {};

// Display list of all Manufacturers.
controller.list = asyncHandler(async (req, res, next) => {
  const manufacturers = await Manufacturer.findAll({ attributes: ['id', 'name'], order: seqlz.col('name') });
  res.render("manufacturer_list", {
    user: req.user,
    manufacturers,
  });
});

// Display detail page for a specific Manufacturer.
controller.home = asyncHandler(async (req, res, next) => {
  // Get details of manufacturer and all associated pets (in parallel)
  const manufacturer = await Manufacturer.findOne({ where: { id: req.params.id } });
  if (manufacturer === null) {
    // No results.
    const err = new Error("Fornecedor não encontrado.");
    err.status = 404;
    return next(err);
  }

  res.render("manufacturer_home", {
    user: req.user,
    manufacturer,
  });
});

// update data for a specific Manufacturer.
controller.update = asyncHandler(async (req, res, next) => {
  // Get details of manufacturer and all associated pets (in parallel)
  const manufacturer = await Manufacturer.findOne({where: {id: req.params.id}});
  if (manufacturer === null) {
    // No results.
    const err = new Error("Fornecedor não encontrado.");
    err.status = 404;
    return next(err);
  }

  await Manufacturer.update({
    name: req.body.name,
    descr: req.body.descr,
    web: req.body.web,
  }, {where: {id: req.params.id}});

  res.redirect("/manufacturer/");
});

// Display Manufacturer create form on GET
controller.create = asyncHandler(async (req, res, next) => {
    const manufacturer = new Manufacturer({
      name: req.body.name,
    });

    await manufacturer.save();

    res.redirect("/manufacturer/"+manufacturer.id.toString());
});

// Display Manufacturer create form on GET
controller.delete = asyncHandler(async (req, res, next) => {
  await Manufacturer.destroy({ where: { id: req.params.id }});
  res.redirect("/manufacturer/");
});

export default controller;
