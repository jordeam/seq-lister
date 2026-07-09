import express from "express";
const router = express.Router();

// Require our controllers.
import componentController from "../controllers/component.mjs";
import { ensureAuthenticated } from "../controllers/users.mjs";

/// PET ROUTES ///


// id is group id
router.post("/create/:id", ensureAuthenticated, componentController.create);

// :id is the id of group
router.get("/select/:id", componentController.select);

// delete component
router.get("/:id/delete", ensureAuthenticated, componentController.delete);

// GET supercomponent list
router.get("/:id", componentController.home);

// update on POST
router.post("/:id", ensureAuthenticated, componentController.update);

export default router;
