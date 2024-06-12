const Book = require("../models/book");
const User = require("../models/user");
const Review = require("../models/review");
const ReadingSession = require("../models/reading-session");

const generateBase64String = require("../utils/to-base64-string");
const pdfPageCounter = require("../utils/pdf-page-counter");

class BookController {
  static addBook = async (req, res, next) => {
    const { title, author, description, genre } = req.body;

    const coverImageData = req.files["coverImage"][0];
    const coverImageBase64String = generateBase64String(coverImageData);

    const pdfData = req.files["pdf"][0];
    const pdfBase64String = generateBase64String(pdfData);

    console.log(pdfData);

    const pages = await pdfPageCounter(pdfData);

    try {
      const newBook = new Book({
        title,
        author,
        description,
        genre,
        pages,
        coverImage: coverImageBase64String,
        creator: req.userId,
        pdf: {
          data: pdfBase64String,
          fileName: pdfData.originalname,
        },
        ratings: {
          averageRating: 0,
          numberOfRatings: 0,
        },
      });

      await newBook.save();

      const user = await User.findById(req.userId);

      user.library.push(newBook);

      await user.save();

      res.status(200).json({
        success: true,
        message: "Book saved successfully",
        book: newBook,
      });
    } catch (error) {
      console.log(error);
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static updateBook = async (req, res, next) => {
    const bookId = req.params.bookId;

    const { title, author, description, genre } = req.body;

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
        const coverImageBase64String = generateBase64String(coverImageData);
        book.coverImage = coverImageBase64String;
      }

      if (pdfData) {
        const pdfBase64String = generateBase64String(pdfData);
        book.pdf = {
          data: pdfBase64String,
          fileName: pdfData.originalname,
        };
      }

      await book.save();

      res.status(200).json({
        success: true,
        message: "Book updated successfully",
        book: book,
      });
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
          .status(404)
          .json({ success: false, message: "Book not found!" });
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

      await ReadingSession.deleteMany({ bookId: bookId });

      const users = await User.find();

      for (let user of users) {
        if (user.library) user.library.pull(bookId);
        if (user.bookmarks) user.bookmarks.pull(bookId);
        if (user.currentReadings) user.currentReadings.pull(bookId);
        await user.save();
      }

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
      const genre = req.query.genre;

      const books = await Book.find(
        genre === "All" ? {} : { genre: genre }
      ).sort({
        updatedAt: -1,
      });

      res.status(200).json({ success: true, books: books });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static searchBooks = async (req, res, next) => {
    try {
      const title = req.query.title;

      const books = await Book.find({
        $or: {
          title: { $regex: title, $options: "i" },
        },
      }).sort({
        updatedAt: -1,
      });

      res.status(200).json({ success: true, books: books });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static getLibrayBooks = async (req, res, next) => {
    try {
      const books = await Book.find({ creator: req.userId }).sort({
        updatedAt: -1,
      });
      res.status(200).json({ success: true, books: books });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static toggleBookmarks = async (req, res, next) => {
    const bookId = req.params.bookId;
    try {
      console.log(req.userId);

      const user = await User.findById(req.userId);

      console.log(user);

      if (user.bookmarks.includes(bookId)) {
        user.bookmarks.pull(bookId);

        await user.save();

        res
          .status(200)
          .json({ success: true, message: "Book removed from bookmarks" });
      } else {
        user.bookmarks.push(bookId);

        await user.save();

        res
          .status(200)
          .json({ success: true, message: "Book added to bookmarks" });
      }
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static getBookmarkedBook = async (req, res, next) => {
    try {
      const user = await User.findById(req.userId);

      const books = await Book.find({ _id: { $in: user.bookmarks } }).sort({
        updatedAt: -1,
      });

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
