const express = require("express");
const router = express.Router();
const upload = require("../middlewares/file-upload");
const bookController = require("../controllers/book-controller");

// books/add-book => POST
router.post(
  "/add-book",
  upload.fields([
    { name: "coverImage", maxCount: 1 },
    { name: "pdf", maxCount: 1 },
  ]),
  bookController.addBook
);

// books/ => GET
router.get("/", bookController.getBooks);

module.exports = router;
