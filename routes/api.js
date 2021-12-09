var express = require('express');
var router = express.Router();
var userController = require('../controllers/userController');
var tripRouter = require('./trips');

/* re-route api routes */
router.post('/login', userController.login);
router.post('/register', userController.register);

router.use('/trips', tripRouter);

module.exports = router;
