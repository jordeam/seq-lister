import { seqlz } from '../db.mjs';
import { QueryTypes, Op } from 'sequelize';
import asyncHandler from "express-async-handler";
import Suppliercode from '../models/suppliercode.mjs';
import Supplier from '../models/supplier.mjs';

const controller = {};

// Edit a location entry
// need to pass locationentry, component, and location
controller.home = asyncHandler(async (req, res, next) => {
  const shoplist = await seqlz.query("SELECT c.id AS id, c.name AS cname, g.name AS gname, SUM(le.quant) AS stock, SUM(l.quant * le.quant_unit) AS needed, SUM(l.quant * le.quant_unit - le.quant) AS to_buy, cs.name AS case_name, c.id AS compid FROM locations AS l, groups AS g, components AS c, location_entry AS le, cases AS cs WHERE g.id = c.group_id AND l.id = le.location_id AND l.quant > 0 AND c.id = le.component_id AND c.case_id = cs.id GROUP BY c.id, c.name, g.name, cs.name ORDER BY gname, cname, case_name",
    {
      type: QueryTypes.SELECT
    });

  // Find Mouser supplier ID
  const sup = await Supplier.findOne({where: {name: {[Op.regexp]: 'Mouser'}}});
  const mouser_id = sup.id;

  for (let i = 0; i < shoplist.length; i++) {
    const supcode = await Suppliercode.findOne({where: {component_id: shoplist[i].compid, supplier_id: mouser_id}});
    if (supcode) {
      shoplist[i].supcode = supcode.code;
      shoplist[i].partnumber = supcode.partnumber;
    }
    else {
      shoplist[i].supcode = "";
      shoplist[i].partnumber = "";
    }
  }

  res.render('shoplist_home',
    {
      user: req.user,
      shoplist: shoplist
    });
});

controller.csv = asyncHandler(async (req, res, next) => {
  const shoplist = await seqlz.query("SELECT c.name AS cname, g.name AS gname, sum(le.quant) AS stock, sum(l.quant * le.quant_unit) AS needed, sum(l.quant * le.quant_unit - le.quant) AS to_buy, cs.name AS case_name, c.id AS compid FROM locations AS l, groups AS g, components AS c, location_entry AS le, cases AS cs WHERE g.id = c.group_id AND l.id = le.location_id AND l.quant > 0 AND c.id = le.component_id AND c.case_id = cs.id GROUP BY c.id, c.name, g.name, cs.name ORDER BY gname, cname, case_name",
    {
      type: QueryTypes.SELECT
    });

  // Find Mouser supplier ID
  const sup = await Supplier.findOne({where: {name: {[Op.regexp]: 'Mouser'}}});
  const mouser_id = sup.id;

  for (let i = 0; i < shoplist.length; i++) {
    const supcode = await Suppliercode.findOne({where: {component_id: shoplist[i].compid, supplier_id: mouser_id}});
    if (supcode) {
      shoplist[i].supcode = supcode.code;
      shoplist[i].partnumber = supcode.partnumber;
    }
    else {
      shoplist[i].supcode = "";
      shoplist[i].partnumber = "";
    }
  }

  // initializing the CSV string content with the headers
  let csvData = ["Tipo", "Valor", "Case", "Em Estoque", "Necessário", "A Comprar", "PN", "OrderCode"].join(",") + "\r\n";

  shoplist.forEach((elt) => {
    // populating the CSV content
    // and converting the null fields to ""
    csvData += [elt.gname, '"'+elt.cname+'"', '"'+elt.case_name+'"', elt.stock, elt.needed, elt.to_buy, elt.partnumber, elt.supcode].join(",") + "\r\n";
  });

  // returning the CSV content via the "users.csv" file
  res
    .set({
      "Content-Type": "text/csv",
      "Content-Disposition": `attachment; filename="shoplist.csv"`,
    })
    .send(csvData);
});

export default controller;
