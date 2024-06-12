const ReadingSession = require("../models/reading-session");

const getAllReadingSessionsWithUserDetails = async (currentReadings) => {
  return await ReadingSession.aggregate([
    {
      $match: {
        bookId: {
          $in: currentReadings,
        },
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
};

const getReadingSessionWithUserDetails = async (sessionId) => {
  return await ReadingSession.aggregate([
    {
      $match: {
        _id: sessionId,
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
};

module.exports = {
  getAllReadingSessionsWithUserDetails,
  getReadingSessionWithUserDetails,
};
