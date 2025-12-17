import { seqlz } from '../db.mjs';
import { QueryTypes} from 'sequelize';

import asyncHandler from "express-async-handler";

const controller = {};

/**
 * Escapes the wildcard characters '%', '_', and the escape character '\' for use in a SQL LIKE clause.
 * Assumes the escape character is '\'.
 * @param {string} input The raw search string from the user.
 * @returns {string} The escaped string.
 */
function escapeLikeWildcards(input) {
  // Escape the backslash first, then the other wildcards
  return input.replace(/\\/g, '\\\\').replace(/%/g, '\\%').replace(/_/g, '\\_');
}

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

  // // the block bellow is useless
  // const clocs = [];
  // const cloc = await seqlz.query("SELECT l.id,l.name,le.box,le.quant,le.id FROM locations AS l, location_entry AS le, components AS co WHERE l.id = le.location_id AND le.component_id = co.id AND co.name ~* $1 ORDER BY l.name",
  //                                {
  //                                 bind: [req.body.expr],
  //                                 type: QueryTypes.SELECT,
  //                               });
  // clocs.push(cloc);

  const groups = await seqlz.query("SELECT g.id, g.name FROM groups AS g WHERE g.name ~* $1",
                                    {
                                      bind: [req.body.expr],
                                      type: QueryTypes.SELECT,
                                    });

  const partnumbers = await seqlz.query("SELECT c.id, c.name, g.name AS g_name, sc.partnumber, sc.ordercode, s.name AS s_name, m.name AS m_name, sc.id AS sc_id FROM suppliercodes AS sc, components AS c, groups AS g, suppliers AS s, manufacturers AS m WHERE manufact_id = m.id AND supplier_id = s.id AND component_id = c.id AND group_id = g.id AND (partnumber ~* $1 OR ordercode ~* $1)",
                                    {
                                      bind: [req.body.expr],
                                      type: QueryTypes.SELECT,
                                    });

  for (const i in partnumbers) {
    const locs = await seqlz.query("SELECT l.id, l.name, le.box FROM location_entry AS le INNER JOIN locations AS l ON l.id = le.location_id INNER JOIN suppliercodes AS sc ON sc.id = le.supcode_id WHERE sc.id = $1 ORDER BY l.name", {
      bind: [partnumbers[i].sc_id],
      type: QueryTypes.SELECT
    });
    partnumbers[i].locs = locs;
  }

  res.render("search_home", {
    user: req.user,
    expr: req.body.expr,
    components,
//    clocs,
    groups,
    partnumbers,
  });
});

controller.searchComp = asyncHandler(async (req, res, next) => {
  let query_str;
  if (/onlycomp/.test(req.originalUrl))
    query_str = 'SELECT c.id AS comp_id, c.name AS compname, g.name AS gname, cs.name AS csname FROM components AS c LEFT JOIN cases AS cs ON cs.id = c.case_id LEFT JOIN groups AS g ON g.id = c.group_id WHERE (LOWER(c.name) LIKE LOWER($1)) ORDER BY g.name, c.name, cs.name';
  else if (/comp_pn/.test(req.originalUrl))
    query_str = 'SELECT sc.id, c.id AS comp_id, c.name AS compname, g.name AS gname, cs.name AS csname, sc.partnumber,sc.ordercode, s.name AS supplier, m.name AS manufact FROM suppliercodes AS sc LEFT JOIN  components as C ON sc.component_id = c.id LEFT JOIN cases AS cs ON cs.id = c.case_id LEFT JOIN groups AS g ON g.id = c.group_id LEFT JOIN suppliers AS s ON s.id = sc.supplier_id LEFT JOIN manufacturers AS m ON m.id = sc.manufact_id WHERE (LOWER(c.name) LIKE LOWER($1)) ORDER BY g.name, c.name, cs.name, sc.partnumber';
  else
    query_str = 'SELECT sc.id, c.id AS comp_id, c.name AS compname, g.name AS gname, cs.name AS csname, sc.partnumber,sc.ordercode, s.name AS supplier, m.name AS manufact FROM suppliercodes AS sc LEFT JOIN  components as C ON sc.component_id = c.id LEFT JOIN cases AS cs ON cs.id = c.case_id LEFT JOIN groups AS g ON g.id = c.group_id LEFT JOIN suppliers AS s ON s.id = sc.supplier_id LEFT JOIN manufacturers AS m ON m.id = sc.manufact_id WHERE (LOWER(c.name) LIKE LOWER($1)) ORDER BY g.name, c.name, cs.name, sc.partnumber';
  const components = await seqlz.query(query_str,
    {
      bind: ['%' + escapeLikeWildcards(req.query.expr) + '%'],
      type: QueryTypes.SELECT,
    });
  res.json(components);
});

export default controller;
