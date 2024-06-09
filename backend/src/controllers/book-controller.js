const Book = require("../models/book");
const User = require("../models/user");
const Review = require("../models/review");

const generateBase64String = require("../utils/to-base64-string");
const pdfPageCounter = require("../utils/pdf-page-counter");

class BookController {
  static addBook = async (req, res, next) => {
    const { title, author, description, genre } = req.body;

    const coverImageData = req.files["coverImage"][0];
    const coverImageURL = generateBase64String(coverImageData);

    const pdfData = req.files["pdf"][0];
    const pdfURL = generateBase64String(pdfData);

    const pages = await pdfPageCounter(pdfData);

    try {
      const newBook = new Book({
        title,
        author,
        description,
        genre,
        pages,
        coverImage: coverImageURL,
        creator: req.userId,
        pdf: pdfURL,
        ratings: {
          averageRating: 0,
          numberOfRatings: 0,
        },
      });

      await newBook.save();

      const user = await User.findById(req.userId);

      user.libray.push(newBook);

      await user.save();

      res
        .status(200)
        .json({ success: true, message: "Book saved successfully" });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static updateBook = async (req, res, next) => {
    const { bookId, title, author, description, genre } = req.body;

    const coverImageData = req.files["coverImage"][0];

    const pdfData = req.files["pdf"][0];

    try {
      const book = await Book.findById(bookId);

      if (!book) {
        return res
          .status(200)
          .json({ success: false, message: "Book not found!" });
      }

      if (book.creator.toString() !== req.userId) {
        return res.status(403).json({
          success: false,
          message: "Not Authorized!",
        });
      }

      if (title) book.title = title;

      if (author) book.author = author;

      if (description) book.description = description;

      if (genre) book.genre = genre;

      if (coverImageData) {
        const coverImageURL = generateBase64String(coverImageData);
        book.coverImage = coverImageURL;
      }

      if (pdfData) {
        const pdfURL = generateBase64String(pdfData);
        book.pdf = pdfURL;
      }

      await book.save();

      res
        .status(200)
        .json({ success: true, message: "Book updated successfully" });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static deleteBook = async (req, res, next) => {
    const { bookId } = req.params;

    try {
      const book = await Book.findById(bookId);

      if (!book) {
        return res
          .status(200)
          .json({ success: true, message: "Book not found!" });
      }

      if (book.creator.toString() !== req.userId) {
        return res.status(403).json({
          success: false,
          message: "Not Authorized!",
        });
      }

      const reviews = book.reviews.map((review) => review._id);

      await Book.findByIdAndDelete(bookId);

      await Review.deleteMany({
        _id: { $in: reviews },
      });

      const user = await User.findById(req.userId);

      user.libray.pull(bookId);

      user.bookmarks.pull(bookId);

      await user.save();

      res
        .status(200)
        .json({ success: true, message: "Book deleted successfully" });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static getBook = async (req, res, next) => {
    const { bookId } = req.body;

    try {
      const book = await Book.findById(bookId);

      if (!book) {
        return res
          .status(200)
          .json({ success: true, message: "Book not found!" });
      }

      res.status(200).json({ success: true, book: book });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static getBooks = async (req, res, next) => {
    try {
      const books = await Book.find();
      res.status(200).json({ success: true, books: books });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };
}

module.exports = BookController;
