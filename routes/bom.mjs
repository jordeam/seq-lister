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
router.get('/:id/query', bomController.query);

// Insert an entry in location
router.post('/:id/insert', ensureAuthenticated, bomController.insert);

// Create a component
router.get('/:id/create', ensureAuthenticated, bomController.create);

// Insert a locationentry in location with component name or id
router.post('/:id/insert_comp', ensureAuthenticated, bomController.insertComp);

export default router;
