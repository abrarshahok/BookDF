const express = require("express");
const router = express.Router();

const authController = require("../controllers/auth-controller");
const authValidator = require("../validators/auth-validator");
const {
  validationResultHandler,
} = require("../validators/validation-result-handler");
const isAuth = require("../middlewares/is-auth");

router.post(
  "/signup",
  authValidator.validateSignupRules(),
  validationResultHandler,
  authController.signup
);

router.get(
  "/signin",
  authValidator.validateSigninRules(),
  validationResultHandler,
  authController.signin
);

router.get("/get-user", isAuth, authController.getUser);

module.exports = router;
