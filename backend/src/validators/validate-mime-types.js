const fileFilter = (req, file, cb) => {
  const allowedImageTypes = ["image/jpeg", "image/png", "image/jpg"];
  const allowedPdfTypes = ["application/pdf"];

  if (file.fieldname === "coverImage" || file.fieldname === "pic") {
    if (!allowedImageTypes.includes(file.mimetype)) {
      cb(new Error("Invalid cover image type"), false);
      return;
    }
  } else if (file.fieldname === "pdf") {
    if (!allowedPdfTypes.includes(file.mimetype)) {
      cb(new Error("Invalid PDF type"), false);
      return;
    }
  }

  cb(null, true);
};

module.exports = fileFilter;
