import * as res from "express";

var express = require('express');
var router = express.Router();
var RanNum = require('./makeRanNum.js');

$('#spin').on('click', function () {
    let ranNum = RanNum.secureRandom().toString();
    console.log(ranNum);
    res.render('index', {random_num: ranNum});
});
