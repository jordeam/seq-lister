import { seqlz } from '../db.mjs';
import { QueryTypes, Op} from 'sequelize';
import Location from "../models/location.mjs";
import LocationEntry from "../models/locationentry.mjs";
import Component from "../models/component.mjs";
import Case from "../models/case.mjs";
import Group from "../models/group.mjs";
import asyncHandler from "express-async-handler";
import path from 'path';
import { fileURLToPath } from 'url';
import fs from 'fs';
import lescape from 'escape-latex';
import pkg from 'template-file';
import selflatex from 'node-latex-pdf';
import Suppliercode from '../models/suppliercode.mjs';
import Supplier from '../models/supplier.mjs';

const { render, renderToFolder } = pkg;

const controller = {};

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

function deleteAllFilesInDir(dirPath) {
  try {
    fs.readdirSync(dirPath).forEach(file => {
      fs.rmSync(path.join(dirPath, file));
    });
  } catch (error) {
    console.log(error);
  }
}

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
  const [entries, loc, allLocations] =
        await Promise.all([
          seqlz.query("SELECT location_entry.id, components.name AS cname,groups.name AS gname, component_id, quant, quant_unit, box,labels, cs.name AS csname, supcode_id FROM location_entry, components, groups, cases AS cs WHERE component_id = components.id AND group_id = groups.id AND case_id = cs.id AND location_id = ? ORDER BY groups.name, components.name", {
            replacements: [req.params.id],
            type: QueryTypes.SELECT
          }),
          Location.findOne({where: {id: req.params.id}}),
          Location.findAll(),
        ]);
  if (loc === null) {
    // No results.
    const err = new Error("Localização não encontrada");
    err.status = 404;
    return next(err);
  }

  let gotOne = false;
  console.log("seaching entries");
  for (let entry of entries) {
    if (entry.supcode_id === -1) {
      console.log(`id ${entry.id} supplier code id ${entry.supcode_id} being precessed`);
      gotOne = true;
      const supcodes = await Suppliercode.findAll({where: {component_id: entry.component_id}});
      // set the first supcode, after looks for the active and overwrites it
      console.log(`supcodes.length=${supcodes.length}`);
      if (supcodes.length > 0) {
        console.log(`updating supcodes[0].id=${supcodes[0].id} in entry id ${entry.id}`);
        // TODO: explain why it does not work:
        // await LocationEntry.update({supcode_id: supcodes[0].id}, {where: {id: entry.id}});
        await seqlz.query("UPDATE location_entry SET supcode_id = $1 WHERE id = $2", {
            bind: [supcodes[0].id, entry.id],
            type: QueryTypes.UPDATE,
        });
        for (const supcode of supcodes) {
          if (supcode.active == true) {
            console.log(`updating supcode.id=${supcode.id} in entry id ${entry.id}`);
            // TODO: explain why it does not work:
            // await LocationEntry.update({supcode_id: supcode.id}, {where: {id: entry.id}});
            await seqlz.query("UPDATE location_entry SET supcode_id = $1 WHERE id = $2", {
              bind: [supcode.id, entry.id],
              type: QueryTypes.UPDATE,
            });
          }
        }
      }
      else {
        // Got no one, just set the supcode_id to 0, so it will not be processed anymore
        // TODO: explain why it does not work:
        // await LocationEntry.update({supcode_id: 0}, {where: {id: entry.id}});
        await seqlz.query("UPDATE location_entry SET supcode_id = 0 WHERE id = $1", {
          bind: [entry.id],
          type: QueryTypes.UPDATE,
        });
      }
    }
  }
  if (gotOne) {
    console.log(`Location has at least one entry with partnumber not analised`);
  }
  const entries_w_supcodes = await seqlz.query("SELECT le.id, c.name AS cname, g.name AS gname, le.component_id, le.quant, le.quant_unit, le.box, le.labels, cs.name AS csname, le.supcode_id, sc.partnumber, sc.ordercode FROM location_entry as le LEFT JOIN components as c ON c.id = le.component_id LEFT JOIN cases AS cs ON cs.id = c.case_id LEFT JOIN groups as g ON g.id = c.group_id LEFT JOIN suppliercodes as sc ON sc.id = le.supcode_id WHERE le.location_id = ? ORDER BY g.name, c.name", {
    replacements: [req.params.id],
    type: QueryTypes.SELECT
  });
  res.render(/labels$/.test(req.originalUrl) ? "location_labels" : "location_home", {
    user: req.user,
    location: loc,
    entries: entries_w_supcodes,
    allLocations,
    usingTable: /table$/.test(req.originalUrl),
  });
});

// Update a component of a location
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
    loc.nbox = req.body.nbox;

    await loc.save();

    res.redirect(loc.url+(/table$/.test(req.originalUrl) ? "/table" : ""));
});

// Create a location
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
controller.labels_post = asyncHandler(async (req, res, next) => {
  console.log(`location_id=${req.params.id}`);
  const template_dir = __dirname + '/../public/templates/';
  const component_template = fs.readFileSync(template_dir + 'label-comp.tex', 'utf-8');
  const location_template = fs.readFileSync(template_dir + 'label-loc.tex', 'utf-8');
  //
  // Labels and page lengths
  //
  const nColumns = parseInt(req.body.nColumns);
  const nRows = parseInt(req.body.nRows);
  const pageWidth = parseFloat(req.body.pageWidth); // mm
  const pageHeight = parseFloat(req.body.pageHeight); // mm
  const topMargin = parseFloat(req.body.topMargin); //mm
  const bottomMargin = parseFloat(req.body.bottomMargin); //mm
  const leftMargin = parseFloat(req.body.leftMargin); // mm
  const rightMargin = parseFloat(req.body.rightMargin); // mm
  const tolHeight = 0.1; // mm tolerance in height
  const initPos = parseInt(req.body.initPos) - 1;
  const horizSpacing = parseFloat(req.body.horizSpacing); // mm
  const labelWidth = (pageWidth - leftMargin - rightMargin - (nColumns - 1) * horizSpacing) / nColumns;
  const labelHeight = (pageHeight - tolHeight - topMargin - bottomMargin) / nRows;

  // Initial values
  let row = 1;
  let col = 1;
  let out_str = "";
  const location = await Location.findOne({where: {id: req.params.id}});
  // Initial position
  for (let _ in [...Array(initPos)]) {
    out_str += "\\begin{tikzpicture}\n\\useasboundingbox (0,0) rectangle (\\labelWidth,\\labelHeight);\n\\\end{tikzpicture}%\n";
    // increment position
    if (++col > nColumns) {
      col = 1;
      if (++row > nRows) {
        row = 1;
        out_str += "\\newpage\n\\noindent%\n";
      }
      else
        out_str += "\\\\[-\\lineskip]\n";
    }
    else {
      out_str += `\\hspace*{${horizSpacing}mm}%\n`;
    }
  }
  // Box labels
  console.log(`location.nbox=${location.nbox}`);
  for (let box of [...Array(location.nbox).keys()]) {
    console.log(`box=${box} ${typeof(box)} req.body['nLabes'+box]=${req.body['nLabels'+box]}`);
    const nLabels = parseInt(req.body['nLabels'+box]);
    for (let _ in [...Array(nLabels)]) {
      out_str += render(location_template,
                        {
                          location: lescape(location.name),
                          box: box + 1,
                          enableBorderline: req.body.drawBorderline ? "" : "%",
                        });
      // increment position
      if (++col > nColumns) {
        col = 1;
        if (++row > nRows) {
          row = 1;
          out_str += "\\newpage\n\\noindent%\n";
        }
        else
          out_str += "\\\\[-\\lineskip]\n";
      }
      else {
        out_str += `\\hspace*{${horizSpacing}mm}%\n`;
      }
    }
  }
  // Component labels
  for (let idx in req.body) {
    // console.log(`${idx} = ${req.body[idx]}`);
    const re = idx.toString().match(/^comp_([0-9]+)/);
    // console.log(`re=${re}`);
    if (re && req.body[idx] === 'on') {
      const comp = await Component.findOne({
        where: {id: parseInt(re[1])},
        raw: true,
        include: [
          {
            model: Case,
            required: false,
            attributes: ["name"],
          },
          {
            model: Group,
            required: true,
            attributes: ["name"],
          }]
      });

      const le = await LocationEntry.findOne({where: {location_id: req.params.id, component_id : parseInt(re[1])}});
      const str = render(component_template, {
        component: lescape(comp.name, { preserveFormatting: false }),
        case: lescape(comp['case.name'], { preserveFormatting: false }),
        group: lescape(comp['group.name'], { preserveFormatting: false }),
        location: lescape(location.name, { preserveFormatting: false }),
        box: le.box,
        unit: le.quant_unit,
        enableBorderline: req.body.drawBorderline ? "" : "%",
      });
      out_str += str;
      if (++col > nColumns) {
        col = 1;
        if (++row > nRows) {
          row = 1;
          out_str += "\\newpage\n\\noindent%\n";
        }
        else
          out_str += "\\\\[-\\lineskip]\n";
      }
      else {
        out_str += `\\hspace*{${horizSpacing}mm}%\n`;
      }
    }
  }

  // Create output temporary directory
  const out_dir = __dirname + '/../public/temp/';
  try {
    // check if directory already exists
    if (!fs.existsSync(out_dir)) {
      fs.mkdirSync(out_dir);
      console.log(`Directory ${out_dir} is created.`);
    }
    // else {
    //   console.log("Directory already exists.");
    //   deleteAllFilesInDir(out_dir);
    //   console.log(`Removed all files from ${out_dir}`);
    // }
  } catch (err) {
    console.log(err);
  }

  // Render final template
  await renderToFolder(template_dir + 'label-doc.tex', out_dir, {
    topMargin,
    textHeight: pageHeight - topMargin - bottomMargin,
    leftMargin: -25.4 + leftMargin,
    textWidth: pageWidth - rightMargin - leftMargin,
    labelWidth,
    labelHeight,
    str: out_str,
  });

  // run LaTeX
  selflatex(out_dir + 'label-doc.tex', out_dir, (err,msg) => {
    if(err) {
      console.log(`Error, ${msg}`);
      return res.status(500).send('Could not process TEX file for recipe');
    }
    // const content = fs.readFileSync(out_dir + 'recipe-template.pdf', 'utf-8');
    return res.type('pdf').download(out_dir + 'label-doc.pdf', 'labels.pdf');
  });
});

controller.csv = asyncHandler(async (req, res, next) => {
  const [entries, loc] =
        await Promise.all([
          seqlz.query("SELECT le.id, c.name AS cname, g.name AS gname, le.component_id AS compid, quant, quant_unit, box,labels, cs.name AS case_name FROM location_entry AS le, components AS c, groups AS g, cases AS cs WHERE le.component_id = c.id AND group_id = g.id AND case_id = cs.id AND location_id = ? ORDER BY g.name, c.name", {
            replacements: [req.params.id],
            type: QueryTypes.SELECT
          }),
          Location.findOne({where: {id: req.params.id}})
        ]);

  if (loc === null) {
    // No results.
    const err = new Error("Localização não encontrada");
    err.status = 404;
    return next(err);
  }

  // Find Mouser supplier ID
  const sup = await Supplier.findOne({where: {name: {[Op.regexp]: 'Mouser'}}});
  const mouser_id = sup.id;

  for (let i = 0; i < entries.length; i++) {
    const supcode = await Suppliercode.findOne({where: {component_id: entries[i].compid, supplier_id: mouser_id}});
    if (supcode) {
      entries[i].supcode = supcode.ordercode;
      entries[i].partnumber = supcode.partnumber;
    }
    else {
      entries[i].supcode = "";
      entries[i].partnumber = "";
    }
  }

  // initializing the CSV string content with the headers
  let csvData = ["Item", "Grupo", "Valor", "Case", "Cx", "Estoque", "P/placa", "Saldo", "Labels", "SupCode"].join(",") + "\r\n";
  let i = 1;
  entries.forEach(elt => {
    // populating the CSV content
    // and converting the null fields to ""
    const saldo = elt.quant - loc.quant * elt.quant_unit;
    csvData += [i++, elt.gname, '"'+elt.cname+'"', '"'+elt.case_name+'"', elt.box, elt.quant, elt.quant_unit, saldo, '"'+elt.labels+'"', '"'+elt.supcode.trim()+'"'].join(",") + "\r\n";
  });

  // returning the CSV content via the "users.csv" file
  res
    .set({
      "Content-Type": "text/csv",
      "Content-Disposition": `attachment; filename="${loc.name}.csv"`,
    })
    .send(csvData);
});

// List all components of a location
controller.insert_from = asyncHandler(async (req, res, next) => {
  // get entries from source location id:
    const entries = await LocationEntry.findAll({where: {location_id: req.body.location_id}});

  for (const entry of entries) {
    await LocationEntry.create({labels: entry.labels, location_id: req.params.id, component_id: entry.component_id, quant_unit: entry.quant_unit, box: entry.box});
  }
    res.redirect("/location/"+req.params.id);
});

function csv_remove_quotes(str) {
  const regex = /,(?=(?:(?:[^"]*"){2})*[^"]*$)/;
  let lst = str.split(regex);
  for (let i in lst) {
    lst[i] = lst[i].replace(/\"/g, '');
  }
}

export default controller;
