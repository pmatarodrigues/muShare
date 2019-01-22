var express = require('express');
var router = express.Router();


function isAuthenticated(req, res, next) {
  if (req.isAuthenticated())
      return next();
  res.redirect('/');
}


router.get('/', isAuthenticated, function(req, res, next) {  

  db.query('SELECT * FROM user WHERE username = "' + req.query.user + '"', function(err, result) {
    if(err){        
        throw err;
    } else {
      // GET ALL MUSICS FROM SELECTED USER
      var selectMusicFromUser = 'SELECT name, duration, (SELECT username FROM user WHERE username = "' + req.query.user + '" ) as username, (SELECT pic FROM user WHERE username = "' + req.query.user + '") as pic FROM `music` WHERE user = (SELECT id FROM user WHERE username = "' + req.query.user + '") ORDER BY dateUpload DESC';

      db.query(selectMusicFromUser, function(err, resultMusic) {
        if(err){
          throw err;
        } else{          
          res.render('profile', { title: 'Home', userProfile: result[0], musicList: resultMusic, user: req.user });     
        }
      });           
    }
  });
});


module.exports = router;
