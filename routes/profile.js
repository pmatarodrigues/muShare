var express = require('express');
var router = express.Router();


function isAuthenticated(req, res, next) {
  if (req.isAuthenticated())
      return next();
  res.redirect('/');
}


router.get('/', isAuthenticated, function(req, res, next) {

  let id= "26";

  db.query('SELECT * FROM user WHERE id = ' + id, function(err, result) {
      if(err){
          throw err;
      } else {
        var selectMusicFromUser = "SELECT name, duration, (SELECT username FROM user WHERE id = " + id + " ) as username, (SELECT pic FROM user WHERE id = " + id + ") as pic FROM `music` WHERE user = " + id + " ORDER BY dateUpload DESC";

        db.query(selectMusicFromUser, function(err, resultMusic) {
          if(err){
            throw err;
          } else{
            console.log(resultMusic);               
            res.render('profile', { title: 'Home', userProfile: result[0], musicList: resultMusic, user: req.user });     
          }
        });           
      }
  });
});


module.exports = router;
