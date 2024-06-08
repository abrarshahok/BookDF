const PDFParser = require("pdf-parse");
const fs = require("fs");

const createTempDir = async () => {
  const tempDir = "./temp/";
  try {
    if (!fs.existsSync(tempDir)) {
      fs.mkdirSync(tempDir);
    }
    return tempDir;
  } catch (error) {
    throw new Error("Error creating temporary directory");
  }
};

const createTempFilePath = async (pdfData, tempDir) => {
  try {
    const tempFilePath = `${tempDir}${pdfData.originalname}`;
    return tempFilePath;
  } catch (error) {
    throw new Error("Error creating temporary file path");
  }
};

const countPages = async (pdfData) => {
  try {
    const tempDir = await createTempDir();
    const tempFilePath = await createTempFilePath(pdfData, tempDir);

    // Write the PDF data to the temporary file
    fs.writeFileSync(tempFilePath, pdfData.buffer);

    const dataBuffer = fs.readFileSync(tempFilePath);
    const pdfPageData = await PDFParser(dataBuffer);
    const pages = pdfPageData.numpages;

    // Delete the temporary PDF file after counting pages
    fs.unlinkSync(tempFilePath);

    return pages;
  } catch (error) {
    throw new Error("Error counting pages");
  }
};

module.exports = countPages;
