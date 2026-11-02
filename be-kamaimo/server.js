const app = require('./src/app');
const { PORT, NODE_ENV } = require('./src/config/env');

const server = app.listen(PORT, () => {
  console.log(`\n🌲 Berani Kamaimo API running in ${NODE_ENV} mode`);
  console.log(`🌐 http://localhost:${PORT}/api`);
  console.log(`📚 Endpoint: /api/{user,atraksi,desaWisata,jarak,kuliner,rumahMakan,hotel,tourPackage,ulasan,visitor,pageview,kunjunganTuris,weather,gis}\n`);
});

// graceful shutdown
process.on('SIGTERM', () => server.close(() => process.exit(0)));
process.on('SIGINT', () => server.close(() => process.exit(0)));
