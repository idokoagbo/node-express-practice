var express = require('express');
var router = express.Router();
var tripController = require('../controllers/tripController');

/*  routes */

router.get('/', tripController.getTrips);
router.post('/', tripController.create);

module.exports = router;
