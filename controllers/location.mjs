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

// Maximum chars in one line, for labels
const MAXLINECHARS = 60;

const paperTypes = [
  {id: 0, name: 'A4 Paper', value: 'a4paper', width: 210, height: 297},
  {id: 1, name: 'US Letter', value: 'letter', width: 8.5*25.4, height: 11*25.4},
];

// List all locations
controller.list = asyncHandler(async (req, res, next) => {
  // const otherLocations = await Location.findAll({where: {quant: 0}, order: seqlz.col('name')});
  const underConst = await Location.findAll({where: {quant: {[Op.not]: 0}}, order: seqlz.col('name')});
  const activeLocs = await Location.findAll({ where: { quant: 0, active: true}, order: seqlz.col('name') });
  const inactiveLocs = await Location.findAll({ where: { quant: 0, active: false }, order: seqlz.col('name') });

  res.render("location_list", {
    user: req.user,
    underConst,
    activeLocs,
    inactiveLocs,
  });
});

function breakLine(text, limit) {
  // regex search any char up to limit, but ending in [, . ! ? or spc]
  const regex = new RegExp(`(.{1,${limit}})([,.!?\\s]|$)`, 'g');

  return text.match(regex).map(line => line.trim());
}

// List all components of a location
controller.home = asyncHandler(async (req, res, next) => {
  const [loc, allLocations] =
        await Promise.all([
          Location.findOne({where: {id: req.params.id}}),
          Location.findAll(),
        ]);
  if (loc === null) {
    // No results.
    const err = new Error("Localização não encontrada");
    err.status = 404;
    return next(err);
  }

  const entries = await seqlz.query("SELECT le.id, c.name AS cname, g.name AS gname, sc.component_id, le.quant, le.quant_unit, le.box, le.labels, le.sent, cs.name AS csname, le.supcode_id, sc.partnumber, sc.ordercode FROM location_entry AS le LEFT JOIN suppliercodes AS sc ON sc.id = le.supcode_id LEFT JOIN components AS c ON c.id = sc.component_id LEFT JOIN cases AS cs ON cs.id = c.case_id LEFT JOIN groups AS g ON g.id = c.group_id WHERE le.location_id = ? ORDER BY g.name, c.name", {
    replacements: [req.params.id],
    type: QueryTypes.SELECT
  });
  for (const [i, elt] of entries.entries()) {
    let match = /(^|((.*)\s+))env\s+([0-9]*)/.exec(elt.labels);
    if (match) {
      elt.sent = match[4];
      elt.labels = match[3];
      const le = await LocationEntry.findOne({where: {id: elt.id}});
      le.sent = +elt.sent;
      le.labels = elt.labels;
      await le.save();
    }
    // break line after x chars
    if (elt.labels.length > MAXLINECHARS + 4) {
      elt.labels = breakLine(elt.labels, MAXLINECHARS);
      // console.log(elt.labels);
    }
    const { count } = await Suppliercode.findAndCountAll({
      where: { component_id: elt.component_id },
    });
    console.log(`nOpt=${count} component_id=${elt.component_id}`);
    entries[i].nOpt = count;
  }
  res.render("location_home", {
    user: req.user,
    location: loc,
    entries,
    allLocations,
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
    loc.name = req.body.name.trim();
    loc.quant = req.body.quant;
    loc.note = req.body.note;
    loc.nbox = req.body.nbox;
  loc.active = req.body.active ? true : false;

    await loc.save();
    res.redirect(loc.url);
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

// List all components of a location for labels
controller.labels = asyncHandler(async (req, res, next) => {
  const loc = await Location.findOne({where: {id: req.params.id}});
  if (loc === null) {
    // No results.
    const err = new Error("Localização não encontrada");
    err.status = 404;
    return next(err);
  }

  const entries = await seqlz.query("SELECT le.id, c.name AS cname, g.name AS gname, sc.component_id, le.quant, le.quant_unit, le.box, le.labels, cs.name AS csname, le.supcode_id, sc.partnumber, sc.ordercode FROM location_entry AS le LEFT JOIN suppliercodes AS sc ON sc.id = le.supcode_id LEFT JOIN components AS c ON c.id = sc.component_id LEFT JOIN cases AS cs ON cs.id = c.case_id LEFT JOIN groups AS g ON g.id = c.group_id WHERE le.location_id = ? ORDER BY g.name, c.name", {
    replacements: [req.params.id],
    type: QueryTypes.SELECT
  });
  res.render("location_labels", {
    user: req.user,
    location: loc,
    paperTypes,
    entries: entries,
  });
});

/**
 * Generates the final pdf file with the labels.
 */
controller.labels_post = asyncHandler(async (req, res, next) => {
  const loc_id = req.params.id; // location id
  console.log(`location_id=${loc_id}`);
  const template_dir = __dirname + '/../public/templates/';
  const component_template = fs.readFileSync(template_dir + 'label-comp.tex', 'utf-8');
  const location_template = fs.readFileSync(template_dir + 'label-loc.tex', 'utf-8');
  //
  // Labels and page lengths
  //
  const nColumns = parseInt(req.body.nColumns);
  const nRows = parseInt(req.body.nRows);
  const paperId = parseInt(req.body.paperId);
  const pageWidth = paperTypes[paperId].width;
  const pageHeight = paperTypes[paperId].height;
  const topMargin = parseFloat(req.body.topMargin); //mm
  const bottomMargin = parseFloat(req.body.bottomMargin); //mm
  const leftMargin = parseFloat(req.body.leftMargin); // mm
  const rightMargin = parseFloat(req.body.rightMargin); // mm
  const tolHeight = 0.1; // mm tolerance in height
  const initPos = parseInt(req.body.initPos) - 1;
  const horizSpacing = parseFloat(req.body.horizSpacing); // mm
  const labelWidth = (pageWidth - leftMargin - rightMargin - (nColumns - 1) * horizSpacing) / nColumns;
  const labelHeight = (pageHeight + tolHeight * (nRows - 1) - topMargin - bottomMargin) / nRows;

  console.log(`labelWidth=${labelWidth}`);
  console.log(`labelHeight=${labelHeight}`);

  // Initial values
  let row = 1;
  let col = 1;
  let out_str = "";
  const location = await Location.findOne({where: {id: loc_id}});
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
        // out_str += "\\\\\n";
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
          // out_str += "\\\\\n";
      }
      else {
        out_str += `\\hspace*{${horizSpacing}mm}%\n`;
      }
    }
  }
  // Component labels
  for (let idx in req.body) {
    // console.log(`idx: ${idx} = ${req.body[idx]}`);
    const re = idx.toString().match(/^sc_([0-9]+)/);
    // console.log(`re=${re}`);
    if (re && req.body[idx] === 'on') {
      const supcode_id = parseInt(re[1]);
      // console.log(`supcode_id=${supcode_id}`);
      const supcode = await Suppliercode.findOne({where: {id: supcode_id}, raw: true});
      const comp = await Component.findOne({
        where: {id: supcode.component_id},
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

      const le = await LocationEntry.findOne({where: {location_id: req.params.id, supcode_id : supcode_id}});
      const labels = le.labels.split(/\s*,\s*/);
      const str = render(component_template, {
        component: lescape(comp.name, { preserveFormatting: false }),
        case: lescape(comp['case.name'], { preserveFormatting: false }),
        group: lescape(comp['group.name'], { preserveFormatting: false }),
        location: lescape(location.name, { preserveFormatting: false }),
        box: le.box,
        unit: le.quant_unit,
        labels: req.body.includeRefs ? labels.join(', ') : "",
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
          // out_str += "\\\\\n";
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
    paperType: paperTypes[paperId].value,
    pageHeight,
    pageWidth,
    topMargin,
    bottomMargin,
    textHeight: pageHeight - topMargin - bottomMargin,
    leftMargin: -25.4 + leftMargin,
    // leftMargin,
    rightMargin,
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
          seqlz.query("SELECT le.id, c.name AS cname, g.name AS gname, sc.component_id AS compid, quant, quant_unit, box,labels, cs.name AS case_name FROM location_entry AS le LEFT JOIN suppliercodes AS sc ON sc.id = le.supcode_id LEFT JOIN components AS c ON c.id = sc.component_id LEFT JOIN  groups AS g ON g.id = c.group_id LEFT JOIN cases AS cs ON cs.id = c.case_id WHERE location_id = ? ORDER BY g.name, c.name", {
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

// Insert component in location: deprecated: must insert by partnumber
controller.insert_from = asyncHandler(async (req, res, next) => {
  // get entries from source location id:
    const entries = await LocationEntry.findAll({where: {location_id: req.body.location_id}});

  for (const entry of entries) {
    await LocationEntry.create({
      labels: entry.labels,
      location_id: req.params.id,
      component_id: entry.component_id, // must use partnumber
      quant_unit: entry.quant_unit,
      box: entry.box});
  }
    res.redirect("/location/"+req.params.id);
});

controller.saveParams = asyncHandler(async (req, res, next) => {
  const loc_id = req.params.id; // location id
  console.log(`saveParams: location_id=${loc_id}`);
  await Location.update({
    n_columns: parseInt(req.body.nColumns),
    n_rows: parseInt(req.body.nRows),
    paper_type: parseInt(req.body.paperId),
    // page_width: parseFloat(req.body.pageWidth), // mm
    // page_height: parseFloat(req.body.pageHeight), // mm
    top_margin: parseFloat(req.body.topMargin), //mm
    bottom_margin: parseFloat(req.body.bottomMargin), //mm
    left_margin: parseFloat(req.body.leftMargin), // mm
    right_margin: parseFloat(req.body.rightMargin), // mm
    horiz_spacing: parseFloat(req.body.horizSpacing), // mm
  },
                        {
                          where: {id: loc_id},
                        });
  res.set({
    "Content-Type": "text/html",
  })
    .send("<p> Dados salvos </p>");
});

export default controller;
