const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const userSchema = new Schema({
  username: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  pic: {
    fileName: String,
    data: Buffer,
    contentType: String,
  },
  libray: [
    {
      type: Schema.Types.ObjectId,
      ref: "Book",
    },
  ],
  bookmarks: [
    {
      type: Schema.Types.ObjectId,
      ref: "Book",
    },
  ],
});

const User = mongoose.model("User", userSchema);

module.exports = User;
