const Review = require("../models/review");
const Book = require("../models/book");

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

const getReviews = (req, res, next) => {};

module.exports = { addReview, getReviews };
