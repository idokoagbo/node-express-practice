var express = require('express');
var router = express.Router();
var userController = require('../controllers/userController');

/* re-route api routes */
router.post('/login', userController.login);
router.post('/register', userController.register);

module.exports = router;
