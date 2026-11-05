const router = require('express').Router();
const controller = require('../controllers/event-rating.controller');

router.get('/:eventKey', controller.summary);
router.post('/:eventKey', controller.submit);

module.exports = router;
