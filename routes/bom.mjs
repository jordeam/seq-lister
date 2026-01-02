import express from "express";
const router = express.Router();

// Require our controllers.
import bomController from "../controllers/bom.mjs";
import { ensureAuthenticated } from "../controllers/users.mjs";

/// PET ROUTES ///

// GET redirect to location list
router.get("/", bomController.list);

// Bom edit for a location :id
router.get('/:id', bomController.home);

// Upload a BOM list
router.post('/:id/upload', ensureAuthenticated, bomController.upload);

// Query a line of a BOM list
router.get('/:id/search_pn', bomController.search_pn);

// Insert an entry in location with the same partnumber
router.post('/:id/insert_pn', ensureAuthenticated, bomController.insert_pn);

// Create a component
router.get('/:id/create', ensureAuthenticated, bomController.create);

// Insert using a existing PN
router.get('/:id/insExistPN', ensureAuthenticated, bomController.insertExistingPN);

// Insert a locationentry in location with component name or id
router.post('/:id/insert_comp', ensureAuthenticated, bomController.insertComp);

// Insert a locationentry in location with an existing partnumber and  component name
router.post('/:id/insert_comp_w_pn', ensureAuthenticated, bomController.insertCompWithPN);

// Change the status character of a BOM line in location :id
router.get('/:id/change', ensureAuthenticated, bomController.changeStatus);

export default router;
