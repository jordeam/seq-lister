import express from 'express';
const router = express.Router();

import asyncHandler from "express-async-handler";

const index = asyncHandler(async (req, res, next) => {
  res.redirect("/supergroup");
});

/* GET home page. */
router.get("/", index);

router.get('/favicon.ico', function (req, res) {
  res.download('./public/images/favicon.ico');
});

// module.exports = router;
export default router;
