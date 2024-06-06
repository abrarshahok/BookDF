const express = require("express");
const router = express.Router();

const reviewController = require("../controllers/review-controller");

// book/reviews
router.get("/", reviewController.getReviews);

router.post("/add-review", reviewController.addReview);

module.exports = router;
