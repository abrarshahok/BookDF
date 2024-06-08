const bufferToBase64 = (fileData) => {
  return fileData.buffer.toString("base64");
};

const generateBase64String = (fileData) => {
  const base64String = bufferToBase64(fileData);
  const contentType = fileData.mimetype;
  return `data:${contentType};base64,${base64String}`;
};

module.exports = generateBase64String;
