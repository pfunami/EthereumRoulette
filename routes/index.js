var express = require('express');
var router = express.Router();
var RanNum = require('../public/javascripts/makeRanNum');

/* GET home page. */
router.get('/', function(req, res, next) {

  res.render('index', { title: 'EthRoulette' });
});




module.exports = router;
