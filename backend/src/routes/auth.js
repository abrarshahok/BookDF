const express = require("express");
const router = express.Router();

const AuthController = require("../controllers/auth-controller");
const authValidator = require("../validators/auth-validator");
const {
  validationResultHandler,
} = require("../validators/validation-result-handler");
const isAuth = require("../middlewares/is-auth");

router.post(
  "/signup",
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
