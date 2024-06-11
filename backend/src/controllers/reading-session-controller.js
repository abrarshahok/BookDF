const ReadingSession = require("../models/reading-session");
const User = require("../models/user");
const Book = require("../models/book");

class ReadingSessionController {
  static createSession = async (req, res) => {
    const { totalPages } = req.body;
    const bookId = req.params.bookId;

    try {
      const isFound = await ReadingSession.findOne({
        bookId: bookId,
        userId: req.userId,
      });

      if (isFound) {
        return res.status(404).json({ message: "Session already available" });
      }

      const session = new ReadingSession({
        userId: req.userId,
        bookId,
        totalPages,
      });

      await session.save();

      const user = await User.findById(req.userId);
      user.currentReadings.push(bookId);
      await user.save();

      const sessionWithBookDetails = await ReadingSession.aggregate([
        {
          $match: {
            _id: session._id,
          },
        },
        {
          $lookup: {
            from: "books",
            localField: "bookId",
            foreignField: "_id",
            as: "bookDetails",
          },
        },
        {
          $unwind: {
            path: "$bookDetails",
            preserveNullAndEmptyArrays: true,
          },
        },
      ]);

      if (sessionWithBookDetails.length === 0) {
        return res
          .status(404)
          .json({ message: "Session not found after creation" });
      }

      res
        .status(200)
        .json({ success: true, session: sessionWithBookDetails[0] });
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  };

  static updateSession = async (req, res) => {
    const { currentPage } = req.body;
    const sessionId = req.params.sessionId;
    try {
      const session = await ReadingSession.findById(sessionId);

      if (!session) {
        return res.status(400).json({ message: "Session not found" });
      }

      if (session.userId.toString() !== req.userId) {
        return res.status(402).json({ message: "Unauthorized" });
      }

      if (currentPage <= session.currentPage) {
        return res.status(404).json({
          message:
            "New current page cannot be less than or equal old current page",
        });
      }

      if (currentPage > session.totalPages) {
        return res.status(404).json({
          message: "New current page cannot be greater than total pages",
        });
      }

      session.currentPage = currentPage;

      await session.save();

      res.status(200).json({ success: true, session: session });
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  };

  static getSessions = async (req, res) => {
    try {
      const userId = req.userId;

      const user = await User.findById(userId);

      const sessions = await ReadingSession.aggregate([
        {
          $match: {
            bookId: { $in: user.currentReadings },
          },
        },
        {
          $lookup: {
            from: "books",
            localField: "bookId",
            foreignField: "_id",
            as: "bookDetails",
          },
        },
        {
          $unwind: {
            path: "$bookDetails",
            preserveNullAndEmptyArrays: true,
          },
        },
      ]).sort({ updatedAt: -1 });

      res.status(200).json({ success: true, sessions });
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  };
}

module.exports = ReadingSessionController;
