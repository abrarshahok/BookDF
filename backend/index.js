const express = require("express");
const morgan = require("morgan");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const app = express();
const bookRoutes = require("./src/routes/book");
const authRoutes = require("./src/routes/auth");
const readingSessions = require("./src/routes/reading-session");
const isAuth = require("./src/middlewares/is-auth");
require("dotenv").config();

app.use(bodyParser.json());

// Prevent CORS Error
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
  res.setHeader(
    "Access-Control-Allow-Methods",
    "GET, POST, PUT, PATCH, DELETE"
  );
  next();
});

app.get("/", (req, res, next) => {
  res.send({
    Developer: "Abrar Ahmed Shahok",
    App: "BookDF",
    Status: "Live",
    Version: "1.0.0",
  });
});
app.use("/auth", authRoutes);
app.use("/books", isAuth, bookRoutes);
app.use("/readingSessions", isAuth, readingSessions);

mongoose
  .connect(process.env.MONGODB_URI)
  .then((res) => {
    app.listen(process.env.PORT || 3000);
    console.log("Connected!");
  })
  .catch((err) => {
    console.log(err);
  });

mongoose.set("debug", true);
