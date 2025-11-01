import { seqlz } from '../db.mjs';
import Suppliercode from "../models/suppliercode.mjs";
import Supplier from "../models/supplier.mjs";
import Manufacturer from "../models/manufacturer.mjs";
import Component from '../models/component.mjs';
import Group from '../models/group.mjs';

import asyncHandler from "express-async-handler";
import { QueryTypes } from 'sequelize';

const controller = {};

// Display detail page for a specific Suppliercode.
controller.home = asyncHandler(async (req, res, next) => {
  // Get details of suppliercode and all associated pets (in parallel)
  const suppliercode = await Suppliercode.findOne({where: {id: req.params.id}});

  if (suppliercode === null) {
    // No results.
    const err = new Error("Código de fornecedor não encontrado.");
    err.status = 404;
    return next(err);
  }

  const component = await Component.findOne({where: {id: suppliercode.component_id}});
  const group = await Group.findOne({where: {id: component.group_id}});

  const [suppliers, manufacturers] = await Promise.all([
    Supplier.findAll({order: seqlz.col('name')}),
    Manufacturer.findAll({order: seqlz.col('name')}),
  ]);

  const locs = await seqlz.query("SELECT l.id, l.name, le.box FROM location_entry AS le LEFT JOIN locations AS l ON l.id = le.location_id WHERE le.supcode_id = $1", {
    bind: [suppliercode.id],
    type: QueryTypes.SELECT,
  });
  console.log(locs);

  res.render("suppliercode_home", {
    user: req.user,
    suppliercode,
    component,
    group,
    suppliers,
    manufacturers,
    locs,
  });
});

// update data for a specific Suppliercode.
controller.update = asyncHandler(async (req, res, next) => {
  // Get details of suppliercode and all associated pets (in parallel)
  const suppliercode = await Suppliercode.findOne({where: {id: req.params.id}});
  if (suppliercode === null) {
    // No results.
    const err = new Error("Entrada de código de compra não encontrada.");
    err.status = 404;
    return next(err);
  }

  await Suppliercode.update({
    ordercode: req.body.ordercode.trim(),
    supplier_id: req.body.supplier,
    manufact_id: req.body.manufact.trim(),
    partnumber: req.body.partnumber.trim(),
    descr: req.body.descr.trim(),
    rounding: req.body.rounding,
  }, {where: {id: req.params.id}});

  res.redirect("/component/"+suppliercode.component_id);
});

// Display Suppliercode create form on GET
controller.create = asyncHandler(async (req, res, next) => {
    const suppliercode = new Suppliercode({
      partnumber: req.body.partnumber.trim(),
      component_id: req.params.id,
    });

    await suppliercode.save();

    res.redirect("/suppliercode/"+suppliercode.id);
});

// Display Suppliercode create form on GET
controller.delete = asyncHandler(async (req, res, next) => {
  const sc = await Suppliercode.findOne({where: {id: req.params.id}});
  const component_id = sc.component_id;
  await sc.destroy();
  res.redirect("/component/"+component_id);
});

export default controller;
