import express from "express";
const router = express.Router();

// Require our controllers.
import caseController from "../controllers/case.mjs";
import { ensureAuthenticated } from "../controllers/users.mjs";

/// PET ROUTES ///

// GET cases list
router.get("/", caseController.list);
// router.post('/create', caseController.create);
router.get('/create', caseController.create);
router.post('/create', caseController.create_post);
router.get("/:id", caseController.home);
router.post("/:id", ensureAuthenticated, caseController.update);
router.get('/:id/delete', caseController.delete);


export default router;
