import { seqlz } from '../db.mjs';
import { QueryTypes } from 'sequelize';
import asyncHandler from "express-async-handler";

const controller = {};

// Edit a location entry
// need to pass locationentry, component, and location
controller.home = asyncHandler(async (req, res, next) => {
  const shoplist = await seqlz.query("select c.id as id, c.name as cname, g.name as gname, sum(le.quant) as stock, sum(l.quant * le.quant_unit) as needed, sum(l.quant * le.quant_unit - le.quant) as to_buy, cs.name as case_name from locations as l, groups as g, components as c, location_entry as le, cases as cs where g.id = c.group_id and l.id = le.location_id and l.quant > 0 and c.id = le.component_id and c.case_id = cs.id group by c.id, c.name, g.name, cs.name order by gname, cname, case_name",
    {
      type: QueryTypes.SELECT
    });
  res.render('shoplist_home',
    {
      user: req.user,
      shoplist: shoplist
    });
});

controller.csv = asyncHandler(async (req, res, next) => {
  const shoplist = await seqlz.query("select c.name as cname, g.name as gname, sum(le.quant) as stock, sum(l.quant * le.quant_unit) as needed, sum(l.quant * le.quant_unit - le.quant) as to_buy, cs.name as case_name from locations as l, groups as g, components as c, location_entry as le, cases as cs where g.id = c.group_id and l.id = le.location_id and l.quant > 0 and c.id = le.component_id and c.case_id = cs.id group by c.id, c.name, g.name, cs.name order by gname, cname, case_name",
    {
      type: QueryTypes.SELECT
    });

  // initializing the CSV string content with the headers
  let csvData = ["tipo", "valor", "Case", "Em estoque", "Necessário", "A comprar"].join(",") + "\r\n";

  shoplist.forEach((elt) => {
    // populating the CSV content
    // and converting the null fields to ""
    csvData += [elt.gname, '"'+elt.cname+'"', '"'+elt.case_name+'"', elt.stock, elt.needed, elt.to_buy].join(",") + "\r\n";
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
