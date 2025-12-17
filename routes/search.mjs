import express from "express";
const router = express.Router();

// Require our controllers.
import searchController from "../controllers/search.mjs";

/// PET ROUTES ///

// GET searchs list
router.get("/", searchController.get);
router.get("/comp", searchController.searchComp);
router.get("/onlycomp", searchController.searchComp);
router.get("/comp_pn", searchController.searchComp);
router.post('/', searchController.post);

export default router;
