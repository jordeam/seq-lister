import { seqlz } from '../db.mjs';
import { QueryTypes, Op} from 'sequelize';
import Location from "../models/location.mjs";
import asyncHandler from "express-async-handler";

const controller = {};

// List all locations
controller.list = asyncHandler(async (req, res, next) => {
  const otherLocations = await Location.findAll({where: {quant: 0}, order: seqlz.col('name')});
  const underConst = await Location.findAll({where: {quant: {[Op.not]: 0}}, order: seqlz.col('name')});
  res.render("location_list", {
    user: req.user,
    otherLocations,
    underConst,
  });
});

// List all components of a location
controller.home = asyncHandler(async (req, res, next) => {
  // Get details of supergroup and all associated pets (in parallel)
  const [entries, loc] =
        await Promise.all(
            [seqlz.query("SELECT location_entry.id, components.name AS cname,groups.name AS gname, component_id, quant, quant_unit, box,labels, cs.name AS csname FROM location_entry, components, groups, cases AS cs WHERE component_id = components.id AND group_id = groups.id AND case_id = cs.id AND location_id = ? ORDER BY groups.name, components.name",
                             { replacements: [req.params.id],
                               type: QueryTypes.SELECT }),
             Location.findOne({where: {id: req.params.id}})]);
  if (loc === null) {
    // No results.
    const err = new Error("Localização não encontrada");
    err.status = 404;
    return next(err);
  }

  let pugURL = '';
  if (/table$/.test(req.originalUrl))
    pugURL = "location_table";
  else if (/labels$/.test(req.originalUrl))
    pugURL = "location_labels";
  else
    pugURL = "location_home";
  res.render(pugURL, {
    user: req.user,
    location: loc,
    entries,
  });
});

// List all components of a location
controller.update = asyncHandler(async (req, res, next) => {
    const loc = await Location.findOne({ where: {id: req.params.id}});

    if (loc === null) {
        // No results.
        const err = new Error("Localização não encontrada");
        err.status = 404;
        return next(err);
    }

    loc.name = req.body.name;
    loc.quant = req.body.quant;
    loc.note = req.body.note;

    await loc.save();

    res.redirect(loc.url);
});

// List all components of a location
controller.create = asyncHandler(async (req, res, next) => {
    const loc = await Location.create({name: req.body.locname});

    res.redirect(loc.url);
});

controller.delete = asyncHandler(async (req, res, next) => {
    const location = await Location.findOne({where: {id: req.params.id}});

    if (location === null) {
        // No results.
        const err = new Error("Localização não encontrada.");
        err.status = 404;
        return next(err);
    }

    await location.destroy();
    res.redirect('/location/');
});

// List all components of a location to print labels
controller.labels = asyncHandler(async (req, res, next) => {
  console.log(`location_id=${req.params.id}`);
  for (let idx in req.body) {
    console.log(`${idx} = ${req.body[idx]}`);
  }


  res.redirect('/location/'+req.params.id+'/labels');
});

export default controller;
