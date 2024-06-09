const ReadingSession = require("../models/reading-session");
const User = require("../models/user");

class ReadingSessionController {
  static createSession = async (req, res) => {
    const { bookId, totalPages } = req.body;

    try {
      const isFound = await ReadingSession.findOne({
        bookId: bookId,
        userId: req.userId,
      });

      console.log(isFound);

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

      console.log(user);

      user.currentReadings.push(session);

      await user.save();

      res.status(200).json({ success: true, session: session });
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
        return res.status(404).json({ message: "Session not found" });
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

      if (currentPage > session.currentPage + 1) {
        return res.status(404).json({
          message: "Cannot increment page by 2",
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
      res.status(400).json({ message: err.message });
    }
  };

  static getSession = async (req, res) => {
    const { bookId } = req.params;
    try {
      const session = await ReadingSession.findOne({
        userId: req.userId,
        bookId: bookId,
      });

      if (!session) {
        return res.status(404).json({ message: "Session not found" });
      }

      res.status(200).json({ success: true, session: session });
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  };
}

module.exports = ReadingSessionController;
