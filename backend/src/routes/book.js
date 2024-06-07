const express = require("express");
const router = express.Router();
const upload = require("../middlewares/file-upload");
const BookController = require("../controllers/book-controller");
const ReviewController = require("../controllers/review-controller");

// books/add-book => POST
router.post(
  "/add-book",
  upload.fields([
    { name: "coverImage", maxCount: 1 },
    { name: "pdf", maxCount: 1 },
  ]),
  BookController.addBook
);

// books/ => GET
router.get("/", BookController.getBooks);

router.post("/:bookId/reviews", ReviewController.addReview);

router.get("/:bookId/reviews", ReviewController.getReviews);

router.delete("/:bookId/reviews", ReviewController.deleteReview);

module.exports = router;
