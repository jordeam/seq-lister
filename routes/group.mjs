import express from "express";
const router = express.Router();

// Require our controllers.
import groupController from "../controllers/group.mjs";
import { ensureAuthenticated } from "../controllers/users.mjs";

/// PET ROUTES ///

// :id is the supergroup id
router.get("/select/:id", groupController.select);

// :id is the supergroup id
router.post("/create/:id", ensureAuthenticated, groupController.create);

// GET group list
router.get("/:id", groupController.home);

// POST group update
router.post("/:id", groupController.update);

// GET group list
router.get("/:id/delete", ensureAuthenticated, groupController.delete);

export default router;
