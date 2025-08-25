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

  res.render("suppliercode_home", {
    user: req.user,
    suppliercode,
    component,
    group,
    suppliers,
    manufacturers,
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

  const active = req.body.active === 'on';

  console.log(`UPDATE id = ${req.params.id} active=${active}`);

  await Suppliercode.update({
    ordercode: req.body.ordercode,
    supplier_id: req.body.supplier,
    manufact_id: req.body.manufact,
    partnumber: req.body.partnumber,
    active,
    rounding: req.body.rounding,
  }, {where: {id: req.params.id}});

  // if active is set to TRUE, then it must set all others to false
  if (active)
    await seqlz.query("UPDATE suppliercodes SET active = false WHERE component_id = $1 AND id <> $2",
                      {
                        bind: [suppliercode.component_id, req.params.id],
                        type: QueryTypes.UPDATE,
                      });
  res.redirect("/component/"+suppliercode.component_id);
});

// Display Suppliercode create form on GET
controller.create = asyncHandler(async (req, res, next) => {
    const suppliercode = new Suppliercode({
      partnumber: req.body.partnumber,
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
