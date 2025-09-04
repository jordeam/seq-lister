import { seqlz } from '../db.mjs';
import { QueryTypes, Op } from 'sequelize';
import asyncHandler from "express-async-handler";
import Suppliercode from '../models/suppliercode.mjs';
import Supplier from '../models/supplier.mjs';

const controller = {};

// Edit a location entry
// need to pass locationentry, component, and location
controller.home = asyncHandler(async (req, res, next) => {
  let shoplist;
  const id = +req.params.id;
  if (id == 0 || id == 1)
    shoplist = await seqlz.query("SELECT c.id AS comp_id, c.name AS cname, g.name AS gname, SUM(le.quant) AS stock, SUM(l.quant * le.quant_unit) AS needed, SUM(l.quant * le.quant_unit - le.quant) AS to_buy, cs.name AS case_name FROM location_entry AS le LEFT JOIN suppliercodes AS sc ON sc.id = le.supcode_id LEFT JOIN components AS c ON c.id = sc.component_id LEFT JOIN groups AS g ON g.id = c.group_id LEFT JOIN cases AS cs ON cs.id = c.case_id LEFT JOIN locations AS l ON l.id = le.location_id WHERE l.quant > 0 GROUP BY c.id, c.name, g.name, cs.name ORDER BY gname, cname, case_name",
    {
      type: QueryTypes.SELECT
    });
  else
    shoplist = await seqlz.query("SELECT c.id AS comp_id, c.name AS cname, g.name AS gname, sc.partnumber, sc.ordercode as ordercode, SUM(le.quant) AS stock, SUM(l.quant * le.quant_unit) AS needed, SUM(l.quant * le.quant_unit - le.quant) AS to_buy, cs.name AS case_name FROM location_entry AS le LEFT JOIN suppliercodes AS sc ON sc.id = le.supcode_id LEFT JOIN components AS c ON c.id = sc.component_id LEFT JOIN groups AS g ON g.id = c.group_id LEFT JOIN cases AS cs ON cs.id = c.case_id LEFT JOIN locations AS l ON l.id = le.location_id WHERE sc.supplier_id = $1 AND l.quant > 0 GROUP BY c.id, c.name, g.name, cs.name, sc.partnumber, sc.ordercode ORDER BY gname, cname, case_name",
    {
      bind: [id],
      type: QueryTypes.SELECT
    });

  const suppliers = await seqlz.query("select s.id, s.name from suppliercodes AS sc LEFT JOIN suppliers AS s ON s.id = sc.supplier_id where component_id IN (select c.id FROM location_entry as le INNER JOIN suppliercodes AS sc ON le.supcode_id = sc.id INNER JOIN components AS c ON c.id = sc.component_id INNER JOIN locations as l ON l.id = le.location_id WHERE l.quant >0 GROUP BY c.id) GROUP BY s.id, s.name", {
    type: QueryTypes.SELECT,
  });

  // List all suppliers
  if (id == 0 ||  id == 1) {
    for (let i = 0; i < shoplist.length; i++) {
      const supcodes_active = await seqlz.query("SELECT s.name, s.id FROM suppliercodes as sc, suppliers as s, location_entry AS le WHERE sc.component_id = $1 AND s.id = sc.supplier_id AND le.supcode_id = sc.id AND s.id > 1 GROUP BY s.name, s.id ORDER BY s.name", {
        bind: [shoplist[i].comp_id],
        type: QueryTypes.SELECT,
      });
      const supcodes_inactive = await seqlz.query("select s.id, s.name from suppliercodes AS sc LEFT JOIN suppliers AS s ON s.id = sc.supplier_id WHERE component_id = $1 AND s.id NOT IN (select s.id FROM components AS c INNER JOIN suppliercodes AS sc ON sc.component_id = c.id INNER JOIN suppliers AS s ON s.id = sc.supplier_id INNER JOIN location_entry AS le ON le.supcode_id = sc.id WHERE c.id = $1 GROUP BY s.id) GROUP BY s.id, s.name", {
        bind: [shoplist[i].comp_id],
        type: QueryTypes.SELECT,
      });
      if (supcodes_active.length > 0) {
        let lst = supcodes_active.map(elt => elt.name);
        shoplist[i].suppliers_a = lst.join(", ");
      }
      if (supcodes_inactive.length > 0) {
        let lst = supcodes_inactive.map(elt => elt.name);
        shoplist[i].suppliers_i = lst.join(", ");
      }
    }
  }

  if (/csv/.test(req.originalUrl)) {
    let csvData;
    // initializing the CSV string content with the headers
    if (id === 0 || id === 1) {
      csvData = ["Item", "Tipo", "Valor ", "Case", "Em Estoque", "Necessário", "A Comprar", "Fornecedor", "Outros fornecedores"].join(",") + "\r\n";
      let i = 0;
      shoplist.forEach((elt) => {
        // populating the CSV content
        // and converting the null fields to ""
        csvData += [++i, elt.gname, '"' + elt.cname + '"', '"' + elt.case_name + '"', elt.stock, elt.needed, elt.to_buy, elt.suppliers_a, elt.suppliers_i].join(",") + "\r\n";
      });
    }
    else {
      csvData = ["Item", "Tipo", "Valor ", "Case", "Em Estoque", "Necessário", "A Comprar", "PN", "OrderCode"].join(",") + "\r\n";
      let i = 0;
      shoplist.forEach((elt) => {
        // populating the CSV content
        // and converting the null fields to ""
        csvData += [++i, elt.gname, '"' + elt.cname + '"', '"' + elt.case_name + '"', elt.stock, elt.needed, elt.to_buy, elt.partnumber, elt.ordercode].join(",") + "\r\n";
      });
    }
    res.set({
      "Content-Type": "text/csv",
      "Content-Disposition": `attachment; filename="shoplist.csv"`,
    })
    .send(csvData);
  }
  else {
    let supplier = await Supplier.findOne({where: {id: id}});
    res.render('shoplist_home', {
      user: req.user,
      id: req.params.id,
      shoplist,
      suppliers,
      supplier,
    });
  }
});

export default controller;
