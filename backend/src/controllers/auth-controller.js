const User = require("../models/user");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const convertToBase64String = require("../utils/to-base64-string");

class AuthController {
  static signup = async (req, res, next) => {
    const { username, email, password } = req.body;

    const picData = req.files["pic"][0];
    const picBase64String = convertToBase64String(picData);

    try {
      const hashedPassword = await bcrypt.hash(password, 12);

      const user = User({
        username: username,
        email: email,
        password: hashedPassword,
        pic: picBase64String,
      });

      await user.save();

      res.status(200).send({ success: true, message: "Signup success." });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static signin = async (req, res, next) => {
    const { email, password } = req.body;

    try {
      const user = await User.findOne({ email: email });

      if (!user) {
        return res
          .status(200)
          .send({ success: false, message: "User with email not found!" });
      }

      const isValid = await bcrypt.compare(password, user.password);

      if (!isValid) {
        return res
          .status(200)
          .send({ success: false, message: "Password does not match!" });
      }

      const token = jwt.sign(
        { email: user.email, userId: user._id.toString() },
        process.env.SECRET_JWT_KEY,
        { expiresIn: "24h" }
      );

      return res
        .status(200)
        .send({ success: true, message: "Signin success.", jwt: token });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static getUser = async (req, res, next) => {
    try {
      const user = await User.findById(req.userId).select("-password");

      if (!user) {
        return res
          .status(200)
          .send({ success: false, message: "User not found!" });
      }

      return res.status(200).send({
        success: true,
        user: user,
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };

  static updateUser = async (req, res, next) => {
    const { username } = req.body;

    let picData = req.files["pic"];

    try {
      const user = await User.findById(req.userId).select("-password");

      if (!user) {
        return res
          .status(200)
          .send({ success: false, message: "User not found!" });
      }

      if (username) user.username = username;

      if (picData) {
        picData = picData[0];
        const picBase64String = convertToBase64String(picData);
        user.pic = picBase64String;
      }

      await user.save();

      return res.status(200).send({
        success: true,
        message: "User updated successfuly",
        user: user,
      });
    } catch (error) {
      console.log(error);
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };
}

module.exports = AuthController;
