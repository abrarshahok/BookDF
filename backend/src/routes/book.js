const express = require("express");
const router = express.Router();
const upload = require("../middlewares/file-upload");
const BookController = require("../controllers/book-controller");
const ReviewController = require("../controllers/review-controller");

router.post(
  "/add-book",
  upload.fields([
    { name: "coverImage", maxCount: 1 },
    { name: "pdf", maxCount: 1 },
  ]),
  BookController.addBook
);

router.patch(
  "/:bookId",
  upload.fields([
    { name: "coverImage", maxCount: 1 },
    { name: "pdf", maxCount: 1 },
  ]),
  BookController.updateBook
);

router.get("/bookmarks", BookController.getBookmarkedBook);

router.get("/", BookController.getBooks);

router.patch("/toggleBookmarks/:bookId", BookController.toggleBookmarks);

router.get("/library", BookController.getLibrayBooks);

router.delete("/:bookId", BookController.deleteBook);

router.post("/:bookId/reviews", ReviewController.addReview);

router.get("/:bookId/reviews", ReviewController.getReviews);

router.delete("/:bookId/reviews", ReviewController.deleteReview);

module.exports = router;
