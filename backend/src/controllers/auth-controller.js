const User = require("../models/user");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

class AuthController {
  static signup = async (req, res, next) => {
    try {
      const { username, email, password } = req.body;

      const hashedPassword = await bcrypt.hash(password, 12);

      const user = User({
        username: username,
        email: email,
        password: hashedPassword,
        pic: {
          filename: req.files["pic"][0].originalname,
          data: req.files["pic"][0].buffer,
          contentType: req.files["pic"][0].mimetype,
        },
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
    try {
      const { email, password } = req.body;

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
      const user = await User.findById(req.userId);

      if (!user) {
        return res
          .status(200)
          .send({ success: false, message: "User not found!" });
      }

      return res.status(200).send({ success: true, user: user });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Internal Server Error!",
        error: error.message,
      });
    }
  };
}

module.exports = AuthController;
