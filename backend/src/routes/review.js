const express = require("express");
const router = express.Router();

const ReviewController = require("../controllers/review-controller");

// book/reviews
router.get("/", ReviewController.getReviews);

router.post("/add-review", ReviewController.addReview);

module.exports = router;
