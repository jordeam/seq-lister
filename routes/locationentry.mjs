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

// fetch request for altering sent in database
router.post("/:id/sent", ensureAuthenticated, locationEntryController.sent);

// fetch request for altering stock in database
router.post("/:id/stock", ensureAuthenticated, locationEntryController.stock);

// change a suppliercode (partnumber) in location_entry
router.post("/:id/newPartnumber", ensureAuthenticated, locationEntryController.newPartnumber);

// fetch request for show component partnumbers in location_entry
router.get("/:id/optcomp", locationEntryController.optcomp);

export default router;
