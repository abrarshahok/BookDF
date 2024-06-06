const express = require("express");
const mongoose = require("mongoose");

const app = express();
const bookRoutes = require("./routes/book");
const authRoutes = require("./routes/auth");

app.use(express.json());

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

app.use("/auth", authRoutes);
app.use("/books", isAuth, bookRoutes);

const uri =
  "mongodb+srv://abrar:21bscs20@cluster0.jlmafxc.mongodb.net/bookDF?retryWrites=true&w=majority&appName=Cluster0";

mongoose
  .connect(uri)
  .then((res) => {
    app.listen(3000);
    console.log("Connected!");
  })
  .catch((err) => {
    console.log(err);
  });

mongoose.set("debug", true);
