const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const bookSchema = new Schema(
  {
    title: {
      type: String,
      required: true,
    },
    author: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    genre: {
      type: String,
      required: true,
    },
    pages: {
      type: Number,
      required: true,
    },
    coverImage: {
      data: Buffer,
      contentType: String,
    },
    pdf: {
      filename: String,
      data: Buffer,
      contentType: String,
    },
    ratings: {
      averageRating: {
        type: Number,
        min: 0,
        max: 5,
      },
      numberOfRatings: {
        type: Number,
        default: 0,
      },
    },
    creator: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    reviews: [
      {
        type: Schema.Types.ObjectId,
        ref: "Review",
      },
    ],
  },
  { timestamps: true }
);

const Book = mongoose.model("Book", bookSchema);
module.exports = Book;
