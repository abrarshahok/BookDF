const Review = require("../models/review");

const getReviewsWithUserDetails = async (reviewIds) => {
  return await Review.aggregate([
    {
      $match: {
        _id: { $in: reviewIds },
      },
    },
    {
      $lookup: {
        from: "users",
        localField: "user",
        foreignField: "_id",
        as: "userDetails",
      },
    },
    {
      $unwind: {
        path: "$userDetails",
        preserveNullAndEmptyArrays: true,
      },
    },
    {
      $project: {
        "userDetails.password": 0,
      },
    },
  ]).sort({ updatedAt: -1 });
};

module.exports = {
  getReviewsWithUserDetails,
};
