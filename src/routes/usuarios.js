const express = require('express');
const router = express.Router();

import * as controller from '../controller/usuarios';

router.post('/', controller.login);

module.exports = router;