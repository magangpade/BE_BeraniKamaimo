const router = require('express').Router();

router.use('/user', require('./user.routes'));
router.use('/uploads', require('./upload.routes'));
router.use('/atraksi', require('./atraksi.routes'));
router.use('/desaWisata', require('./desaWisata.routes'));
router.use('/jarak', require('./jarak.routes'));
router.use('/kuliner', require('./kuliner.routes'));
router.use('/rumahMakan', require('./rumahMakan.routes'));
router.use('/hotel', require('./hotel.routes'));
router.use('/tourPackage', require('./tourPackage.routes'));
router.use('/ulasan', require('./ulasan.routes'));
router.use('/event-rating', require('./event-rating.routes'));
router.use('/visitor', require('./visitor.routes'));
router.use('/pageview', require('./pageview.routes'));
router.use('/kunjunganTuris', require('./kunjunganTuris.routes'));
router.use('/weather', require('./weather.routes'));
router.use('/gis', require('./gis.routes'));

router.get('/', (_req, res) =>
  res.json({ success: true, message: 'Berani Kamaimo API v1', time: new Date() }));

module.exports = router;
