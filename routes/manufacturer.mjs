import express from "express";
const router = express.Router();

// Require our controllers.
import manufactController from "../controllers/manufacturer.mjs";
import { ensureAuthenticated } from "../controllers/users.mjs";

/// PET ROUTES ///

// GET manufact list
router.get("/", manufactController.list);
router.post("/create", ensureAuthenticated, manufactController.create);
router.get("/:id", manufactController.home);
router.post("/:id", ensureAuthenticated, manufactController.update);
router.get("/:id/delete", ensureAuthenticated, manufactController.delete);

export default router;
