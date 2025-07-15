import { seqlz } from '../db.mjs';
import { QueryTypes} from 'sequelize';

import asyncHandler from "express-async-handler";

const controller = {};

// List all components of a location
controller.get = asyncHandler(async (req, res, next) => {
  res.render("search_home", {
    user: req.user,
  });
});

controller.post = asyncHandler(async (req, res, next) => {
  const components = await seqlz.query("SELECT c.id, c.name, g.name AS g_name FROM components AS c, groups AS g WHERE g.id = c.group_id AND c.name ~* $1 ORDER BY g.name, c.name",
                                    {
                                      bind: [req.body.expr],
                                      type: QueryTypes.SELECT,
                                    });

  // the block bellow is useless
  const clocs = [];
  const cloc = await seqlz.query("SELECT l.id,l.name,le.box,le.quant,le.id FROM locations AS l, location_entry AS le, components AS co WHERE l.id = le.location_id AND le.component_id = co.id AND co.name ~* $1 ORDER BY l.name",
                                 {
                                  bind: [req.body.expr],
                                  type: QueryTypes.SELECT,
                                });
    clocs.push(cloc);

  const groups = await seqlz.query("SELECT g.id, g.name FROM groups AS g WHERE g.name ~* $1",
                                    {
                                      bind: [req.body.expr],
                                      type: QueryTypes.SELECT,
                                    });

  const partnumbers = await seqlz.query("SELECT c.id, c.name, g.name AS g_name, sc.partnumber, sc.code, s.name AS s_name, m.name AS m_name from suppliercodes AS sc, components AS c, groups AS g, suppliers AS s, manufacturers AS m WHERE manufact_id = m.id AND supplier_id = s.id AND component_id = c.id AND group_id = g.id AND (partnumber ~* $1 OR code ~* $1)",
                                    {
                                      bind: [req.body.expr],
                                      type: QueryTypes.SELECT,
                                    });


  res.render("search_home", {
    user: req.user,
    expr: req.body.expr,
    components,
    clocs,
    groups,
    partnumbers,
  });
});

export default controller;
