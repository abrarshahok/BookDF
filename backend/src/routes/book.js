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

router.delete("/:bookId", BookController.deleteBook);

router.get("/", BookController.getBooks);

router.post("/:bookId/reviews", ReviewController.addReview);

router.get("/:bookId/reviews", ReviewController.getReviews);

router.delete("/:bookId/reviews", ReviewController.deleteReview);

router.get("/search", BookController.searchBooks);

router.get("/library", BookController.getLibrayBooks);

router.get("/bookmarks", BookController.getBookmarkedBook);

router.patch("/toggleBookmarks/:bookId", BookController.toggleBookmarks);

module.exports = router;
