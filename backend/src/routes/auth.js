const express = require("express");
const router = express.Router();

const AuthController = require("../controllers/auth-controller.js");
const authValidator = require("../validators/auth-validator.js");
const {
  validationResultHandler,
} = require("../validators/validation-result-handler.js");
const isAuth = require("../middlewares/is-auth.js");
const upload = require("../middlewares/file-upload.js");

router.post(
  "/signup",
  upload.fields([{ name: "pic", maxCount: 1 }]),
  authValidator.validateSignupRules(),
  validationResultHandler,
  AuthController.signup
);

router.post(
  "/signin",
  authValidator.validateSigninRules(),
  validationResultHandler,
  AuthController.signin
);

router.get("/get-user", isAuth, AuthController.getUser);

module.exports = router;
