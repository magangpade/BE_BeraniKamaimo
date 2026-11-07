const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const path = require('path');
const rateLimit = require('express-rate-limit');

const routes = require('./routes');
const notFound = require('./middleware/notFound.middleware');
const errorHandler = require('./middleware/error.middleware');
const { CORS_ORIGIN } = require('./config/env');

const app = express();

app.use(helmet({ crossOriginResourcePolicy: false }));
app.use(cors({
  origin: (origin, cb) => {
    if (!origin) return cb(null, true); // mobile / curl
    if (CORS_ORIGIN.length && !CORS_ORIGIN.includes(origin)) {
      // dev: izinkan semua jika kosong
    }
    return cb(null, true);
  },
  credentials: true,
}));
app.use(express.json({ limit: '5mb' }));
app.use(express.urlencoded({ extended: true }));
app.use(morgan('dev'));

// static uploads
app.use('/uploads', express.static(path.join(__dirname, '../public/uploads')));
app.use('/uploads_renamed', express.static(path.join(__dirname, '../public/uploads_renamed')));

// rate limit (kecuali static)
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 500,
  standardHeaders: true,
  legacyHeaders: false,
});
app.use('/api', limiter);

app.use('/api', routes);

app.get('/', (_req, res) =>
  res.json({
    app: 'Berani Kamaimo API',
    version: '1.0.0',
    docs: '/api',
    time: new Date().toISOString(),
  }));

app.use(notFound);
app.use(errorHandler);

module.exports = app;
