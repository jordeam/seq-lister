import express from "express";
const router = express.Router();

// Require our controllers.
import locationController from "../controllers/location.mjs";
import { ensureAuthenticated } from "../controllers/users.mjs";

/// PET ROUTES ///

// GET locations list
router.get("/", locationController.list);
router.post('/create', ensureAuthenticated, locationController.create);
router.get("/:id", locationController.home);
router.post("/:id", ensureAuthenticated, locationController.update);
router.get('/:id/delete', ensureAuthenticated, locationController.delete);
router.get('/:id/labels', locationController.home);
router.post('/:id/labels', locationController.labels_post);
router.get('/:id/csv', locationController.csv);
router.post('/:id/insert_from', locationController.insert_from);

export default router;
