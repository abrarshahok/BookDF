const mongoose = require("mongoose");

const ReadingSessionSchema = new mongoose.Schema(
  {
    userId: { type: mongoose.Schema.ObjectId, ref: "User", required: true },
    bookId: { type: mongoose.Schema.ObjectId, ref: "Book", required: true },
    currentPage: { type: Number, default: 0 },
    totalPages: { type: Number, required: true },
  },
  { timestamps: true }
);

const ReadingSession = mongoose.model("ReadingSession", ReadingSessionSchema);

module.exports = ReadingSession;
