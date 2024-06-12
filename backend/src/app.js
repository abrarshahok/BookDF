const express = require("express");
const morgan = require("morgan");
const mongoose = require("mongoose");
const fs = require("fs");
const bodyParser = require("body-parser");
const path = require("path");
const app = express();
const bookRoutes = require("./routes/book");
const authRoutes = require("./routes/auth");
const readingSessions = require("./routes/reading-session");
const isAuth = require("./middlewares/is-auth");
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

const accessLogStream = fs.createWriteStream(
  path.join(path.resolve(), "access.log"),
  { flags: "a" }
);

app.use(morgan("combined", { stream: accessLogStream }));

app.use("/auth", authRoutes);
app.use("/books", isAuth, bookRoutes);
app.use("/readingSessions", isAuth, readingSessions);

mongoose
  .connect(process.env.DB_URL)
  .then((res) => {
    app.listen(process.env.PORT || 3000);
    console.log("Connected!");
  })
  .catch((err) => {
    console.log(err);
  });

mongoose.set("debug", true);
