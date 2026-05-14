import express from "express";
const router = express.Router();

// Require Controllers.
import locationEntryController from "../controllers/locationentry.mjs";
import { ensureAuthenticated } from "../controllers/users.mjs";

// GET location entries
router.post("/insertnewcomp/:id", ensureAuthenticated, locationEntryController.insertNewComp);
router.get("/choose/:location_id", ensureAuthenticated, locationEntryController.choose);
router.post("/insert/:id", ensureAuthenticated, locationEntryController.insert);
router.get("/:id", locationEntryController.home);
router.post("/:id", ensureAuthenticated, locationEntryController.update);
router.get("/:id/delete", ensureAuthenticated, locationEntryController.delete);

router.post("/:id/sent", ensureAuthenticated, locationEntryController.sent);

export default router;
