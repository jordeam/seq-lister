import express from "express";
const router = express.Router();

// Require our controllers.
import shoplistController from "../controllers/shoplist.mjs";

/// Shop List ///

// GET CSV
router.get("/:id/csv", shoplistController.home);

// GET group list
router.get("/:id", shoplistController.home);


export default router;
