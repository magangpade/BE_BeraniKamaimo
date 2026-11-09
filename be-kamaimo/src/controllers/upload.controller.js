const fs = require('fs/promises');
const path = require('path');
const { v4: uuid } = require('uuid');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

exports.image = asyncHandler(async (req, res) => {
  if (!req.file) throw ApiError.badRequest('Pilih gambar');
  const bytes = req.file.buffer;
  const png = bytes.length >= 8 && bytes.subarray(0, 8).equals(Buffer.from([137,80,78,71,13,10,26,10]));
  const jpeg = bytes.length >= 3 && bytes.subarray(0, 3).equals(Buffer.from([255,216,255]));
  const webp = bytes.length >= 12 && bytes.toString('ascii', 0, 4) === 'RIFF' && bytes.toString('ascii', 8, 12) === 'WEBP';
  const extension = png ? '.png' : jpeg ? '.jpg' : webp ? '.webp' : null;
  if (!extension) throw ApiError.badRequest('Isi gambar harus JPG, PNG, atau WebP');
  const filename = `${uuid()}${extension}`;
  const directory = path.join(__dirname, '../../public/uploads');
  await fs.mkdir(directory, { recursive: true });
  await fs.writeFile(path.join(directory, filename), bytes);
  ApiResponse.created(res, { foto: `/uploads/${filename}` });
});
