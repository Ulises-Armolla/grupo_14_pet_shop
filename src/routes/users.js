const express = require('express');
const router = express.Router();
const userController = require('../controller/usersController');
const uploadAvatar = require('../middleware/uploadAvatar');
const authRouter = require('../middleware/authUsers');
const registerValidator = require('../validation/registerValidator');
const loginValidator = require('../validation/loginValidator');
const profileValidator = require('../validation/profileValidator');

router.get('/register', authRouter.authLogin, userController.register);
router.post('/register', uploadAvatar.single('avatar'), registerValidator, userController.processRegister);

router.get('/login', authRouter.authLogin, userController.login);
router.post('/login',loginValidator, userController.processLogin);
router.get('/logout', userController.logout);


router.get('/profile', authRouter.authProfile, userController.profile);
router.get('/profile/:id/edit', authRouter.authProfile, userController.edit);
router.put('/profile/:id/edit', authRouter.authProfile, uploadAvatar.single('avatar'), profileValidator, userController.update);

module.exports = router;