const express = require("express");
const router = express.Router();
const ReadingSessionController = require("../controllers/reading-session-controller");

router.get("/", ReadingSessionController.getSessions);

router.post("/:bookId", ReadingSessionController.createSession);

router.put("/:sessionId", ReadingSessionController.updateSession);

module.exports = router;
