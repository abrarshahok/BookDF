const Book = require("../models/book");
const Review = require("../models/review");
const User = require("../models/user");

const addBook = async (req, res, next) => {
  try {
    const { title, author, description, genre, pages } = req.body;

    const newBook = new Book({
      title,
      author,
      description,
      genre,
      pages,
      coverImage: {
        data: req.files["coverImage"][0].buffer,
        contentType: req.files["coverImage"][0].mimetype,
      },
      pdf: {
        filename: req.files["pdf"][0].originalname,
        data: req.files["pdf"][0].buffer,
        contentType: req.files["pdf"][0].mimetype,
      },
      ratings: {
        averageRating: 0,
        numberOfRatings: 0,
      },
    });

    await newBook.save();

    const user = await User.findById(req.userId);

    user.libray.push(newBook);

    await user.save();

    res.status(200).json({ success: true, message: "Book saved successfully" });
  } catch (err) {
    console.log(err);
    res.status(500).json({ success: false, message: "Internal Server Error!" });
  }
};

const updateBook = async (req, res, next) => {
  try {
    const { bookId, title, author, description, genre, pages } = req.body;

    const book = await Book.findById(bookId);

    if (!book) {
      return res
        .status(200)
        .json({ success: false, message: "Book not found!" });
    }

    if (title) book.title = title;

    if (author) book.author = author;

    if (description) book.description = description;

    if (genre) book.genre = genre;

    if (pages) book.pages = pages;

    if (req.files["coverImage"]) {
      book.coverImage = {
        data: req.files["coverImage"][0].buffer,
        contentType: req.files["coverImage"][0].mimetype,
      };
    }

    if (req.files["pdf"]) {
      book.pdf = {
        filename: req.files["pdf"][0].originalname,
        data: req.files["pdf"][0].buffer,
        contentType: req.files["pdf"][0].mimetype,
      };
    }

    await book.save();

    res
      .status(200)
      .json({ success: true, message: "Book updated successfully" });
  } catch (err) {
    console.log(err);
    res.status(500).json({ success: false, message: "Internal Server Error!" });
  }
};

const addReview = async (req, res, next) => {
  try {
    const { bookId, rating, reviewText } = req.body;

    const newReview = new Review({
      user: req.userId,
      reviewText: reviewText,
      rating: rating,
    });

    const savedReview = await newReview.save();

    const book = await Book.findById(bookId);

    book.ratings.push(savedReview);

    book.ratings.numberOfRatings += 1;

    book.ratings.averageRating =
      (book.ratings.averageRating * (book.ratings.numberOfRatings - 1) +
        rating) /
      book.ratings.numberOfRatings;

    await book.save();

    res
      .status(200)
      .json({ success: true, message: "Review added successfully." });
  } catch (err) {
    res.status(500).json({ success: false, message: "Internal Server Error!" });
  }
};

const deleteBook = async (req, res, next) => {
  try {
    const { bookId } = req.body;

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

    await Book.findByIdAndDelete(bookId);

    const user = await User.findById(req.userId);

    user.libray.pull(bookId);

    await user.save();

    return res
      .status(200)
      .json({ success: true, message: "Book deleted successfully" });
  } catch (err) {
    console.log(err);
    res.status(500).json({ success: false, message: "Internal Server Error!" });
  }
};

const getBooks = async (req, res, next) => {
  try {
    const books = await Book.find();
    res.status(200).json({ success: true, books: books });
  } catch (err) {
    res.status(500).json({ success: false, message: "Internal Server Error!" });
  }
};

module.exports = {
  addBook,
  addReview,
  getBooks,
  deleteBook,
};
