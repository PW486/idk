import express from 'express';

const router = express.Router();
router.use('/v1/board', require('./router'));

module.exports = router
