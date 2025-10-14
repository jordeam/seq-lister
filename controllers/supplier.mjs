import { QueryTypes } from 'sequelize';
import { seqlz } from '../db.mjs';
import Supplier from "../models/supplier.mjs";

import asyncHandler from "express-async-handler";
// const { param } = require('../app');

const controller = {};

// Display list of all Supplier.
controller.list = asyncHandler(async (req, res, next) => {
  const allSuppliers = await Supplier.findAll({ attributes: ['id', 'name'], order: seqlz.col('name') });
  res.render("supplier_list", {
    user: req.user,
    suppliers_list: allSuppliers,
  });
});

// Display detail page for a specific Supplier.
controller.home = asyncHandler(async (req, res, next) => {
  // Get details of supplier and all associated pets (in parallel)
  const supplier = await Supplier.findOne({ where: { id: req.params.id } });
  if (supplier === null) {
    // No results.
    const err = new Error("Fornecedor não encontrado.");
    err.status = 404;
    return next(err);
  }
  const partnumbers = await seqlz.query("SELECT sc.id, partnumber, m.name AS mname, ordercode, g.name AS gname, c.name AS compname, cs.name AS csname FROM suppliercodes AS sc LEFT JOIN components AS c ON c.id = sc.component_id LEFT JOIN groups AS g ON g.id = c.group_id LEFT JOIN cases AS cs ON cs.id = c.case_id LEFT JOIN manufacturers AS m ON m.id = sc.manufact_id WHERE sc.supplier_id = $1 ORDER BY g.name, c.name, cs.name, partnumber", {
    bind: [req.params.id],
    type: QueryTypes.SELECT,
  });
  res.render("supplier_home", {
    user: req.user,
    supplier,
    partnumbers,
  });
});

// update data for a specific Supplier.
controller.update = asyncHandler(async (req, res, next) => {
  // Get details of supplier and all associated pets (in parallel)
  const supplier = await Supplier.findOne({where: {id: req.params.id}});
  if (supplier === null) {
    // No results.
    const err = new Error("Fornecedor não encontrado.");
    err.status = 404;
    return next(err);
  }

  await Supplier.update({
    name: req.body.name.trim(),
    legalname:req.body.legalname.trim(),
    federal_code: req.body.federal_code.trim(),
    state_code: req.body.state_code.trim(),
    city_code: req.body.city_code.trim(),
    phone: req.body.phone.trim(),
    fax: req.body.fax.trim(),
  }, {where: {id: req.params.id}});

  res.redirect("/supplier/");
});

// Display Supplier create form on GET
controller.create = asyncHandler(async (req, res, next) => {
    const supplier = new Supplier({
      name: req.body.name.trim(),
    });

    await supplier.save();

    res.redirect("/supplier/"+supplier.id.toString());
});

// Display Supplier create form on GET
controller.delete = asyncHandler(async (req, res, next) => {
  await Supplier.destroy({ where: { id: req.params.id }});
  res.redirect("/supplier/");
});

export default controller;
