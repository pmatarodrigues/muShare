var express = require('express');
var router = express.Router();


function isAuthenticated(req, res, next) {
  if (req.isAuthenticated())
    res.redirect('/home');
  return next();
}

/* GET home page. */
router.get('/', isAuthenticated, function(req, res, next) {
  res.render('index', { title: 'Welcome' });
});


module.exports = router;