const express = require("express");
const router = express.Router();
const multer = require("multer");
const fileFilter = require("../validators/validate-mime-types");

const storage = multer.memoryStorage();
const upload = multer({
  limits: { fileSize: 500 * 1024 },
  storage: storage,
  fileFilter: fileFilter,
});

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
