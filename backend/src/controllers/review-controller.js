const Review = require("../models/review");
const Book = require("../models/book");

const { getReviewsWithUserDetails } = require("../services/review-service");

class ReviewController {
  static addReview = async (req, res, next) => {
    const { rating, reviewText } = req.body;
    const { bookId } = req.params;

    try {
      const newReview = new Review({
        user: req.userId,
        reviewText: reviewText,
        rating: rating,
      });

      const savedReview = await newReview.save();

      const book = await Book.findById(bookId);

      book.reviews.push(savedReview);

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
      console.log(err);
      res
        .status(500)
        .json({ success: false, message: "Internal Server Error!" });
    }
  };

  static deleteReview = async (req, res, next) => {
    const { reviewId } = req.body;
    const { bookId } = req.params;

    try {
      const review = await Review.findById(reviewId);

      if (!review) {
        return res
          .status(404)
          .json({ success: false, message: "Review Not Found!" });
      }

      if (review.user.toString() !== req.userId) {
        return res
          .status(402)
          .json({ success: true, message: "Unauthorized!" });
      }

      await Review.findByIdAndDelete(reviewId);

      const book = await Book.findById(bookId);

      book.reviews.pull(reviewId);

      book.ratings.numberOfRatings -= 1;

      if (book.ratings.numberOfRatings !== 0) {
        book.ratings.averageRating =
          (book.ratings.averageRating * (book.ratings.numberOfRatings + 1) -
            review.rating) /
          book.ratings.numberOfRatings;
      }

      await book.save();

      res
        .status(200)
        .json({ success: true, message: "Review deleted successfully." });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static getReviews = async (req, res, next) => {
    const { bookId } = req.params;

    try {
      const book = await Book.findById(bookId);

      if (!book) {
        return res
          .status(404)
          .json({ success: false, message: "Book Not Found!" });
      }

      const reviews = await getReviewsWithUserDetails(book.reviews);

      res.status(200).json({ success: true, reviews: reviews });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };
}

module.exports = ReviewController;
