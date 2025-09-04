import { QueryTypes } from 'sequelize';
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
  const partnumbers = await seqlz.query("SELECT sc.id, partnumber, s.name AS supname, ordercode, g.name AS gname, c.name AS compname, cs.name AS csname FROM suppliercodes AS sc LEFT JOIN components AS c ON c.id = sc.component_id LEFT JOIN groups AS g ON g.id = c.group_id LEFT JOIN cases AS cs ON cs.id = c.case_id LEFT JOIN suppliers AS s ON s.id = sc.supplier_id WHERE sc.manufact_id = $1 ORDER BY g.name, c.name, cs.name, partnumber", {
    bind: [req.params.id],
    type: QueryTypes.SELECT,
  });
  res.render("manufacturer_home", {
    user: req.user,
    manufacturer,
    partnumbers,
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
