import express from "express";
const router = express.Router();

// Require Controllers.
import locationEntryController from "../controllers/locationentry.mjs";
import { ensureAuthenticated } from "../controllers/users.mjs";

// GET location entries
router.post("/insertnewcomp/:id", ensureAuthenticated, locationEntryController.insertNewComp);
router.post("/insertnewcomp/:id/table", ensureAuthenticated, locationEntryController.insertNewComp);
router.get("/choose/:location_id", ensureAuthenticated, locationEntryController.choose);
router.get("/choose/:location_id/table", ensureAuthenticated, locationEntryController.choose);
router.post("/insert/:id", ensureAuthenticated, locationEntryController.insert);
router.post("/insert/:id/table", ensureAuthenticated, locationEntryController.insert);
router.get("/:id", locationEntryController.home);
router.post("/:id", ensureAuthenticated, locationEntryController.update);
router.get("/:id/table", locationEntryController.home);
router.post("/:id/table", ensureAuthenticated, locationEntryController.update);
router.get("/:id/delete", ensureAuthenticated, locationEntryController.delete);
router.get("/:id/delete_table", ensureAuthenticated,
locationEntryController.delete);
export default router;
