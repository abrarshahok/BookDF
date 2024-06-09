const express = require("express");
const router = express.Router();
const ReadingSessionController = require("../controllers/reading-session-controller");

router.get("/", ReadingSessionController.getSessions);

router.post("/create-session", ReadingSessionController.createSession);

router.put("/:sessionId", ReadingSessionController.updateSession);

router.get("/:bookId", ReadingSessionController.getSession);

module.exports = router;
