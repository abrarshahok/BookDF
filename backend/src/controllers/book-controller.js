const Book = require("../models/book");
const Review = require("../models/review");

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

    res.status(201).json({ success: true, message: "Book saved successfully" });
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

    book.ratings.push(savedReview._id);

    book.ratings.numberOfRatings += 1;

    book.ratings.averageRating =
      (book.ratings.averageRating * (book.ratings.numberOfRatings - 1) +
        rating) /
      book.ratings.numberOfRatings;

    await book.save();

    res
      .status(201)
      .json({ success: true, message: "Review added successfully." });
  } catch (err) {
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
};
