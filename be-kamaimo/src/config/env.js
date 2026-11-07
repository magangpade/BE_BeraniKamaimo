require('dotenv').config();

module.exports = {
  PORT: process.env.PORT || 3000,
  NODE_ENV: process.env.NODE_ENV || 'development',
  DB: {
    host: process.env.DB_HOST || process.env.MYSQLHOST || 'localhost',
    port: parseInt(process.env.DB_PORT || process.env.MYSQLPORT || '3306', 10),
    user: process.env.DB_USER || process.env.MYSQLUSER || 'root',
    password: process.env.DB_PASSWORD || process.env.MYSQLPASSWORD || '',
    name: process.env.DB_NAME || process.env.MYSQLDATABASE || 'berani_kamaimo',
  },
  JWT_SECRET: process.env.JWT_SECRET || 'secret',
  JWT_EXPIRES_IN: process.env.JWT_EXPIRES_IN || '7d',
  OPENWEATHER: {
    key: process.env.OPENWEATHER_API_KEY || '',
    baseUrl: process.env.OPENWEATHER_BASE_URL || 'https://api.openweathermap.org/data/2.5',
  },
  CORS_ORIGIN: (process.env.CORS_ORIGIN || '').split(','),
  GIS: {
    defaultLat: parseFloat(process.env.GIS_DEFAULT_LAT || '-1.43'),
    defaultLng: parseFloat(process.env.GIS_DEFAULT_LNG || '121.445'),
  },
};