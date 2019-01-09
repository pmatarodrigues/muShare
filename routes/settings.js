var express = require('express');
var router = express.Router();

function isAuthenticated(req, res, next) {
  if (req.isAuthenticated())
    return next();
  res.redirect('/');
}

/* GET home page. */
router.get('/', isAuthenticated, function(req, res, next) {
  res.render('settings', { title: 'muShare' });
});


module.exports = router;