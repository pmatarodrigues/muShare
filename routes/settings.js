var express = require('express');
var router = express.Router();
var bcrypt = require('bcrypt');
var flash = require('req-flash');


function isAuthenticated(req, res, next) {
  if (req.isAuthenticated())
    return next();
  res.redirect('/');
}

/* GET home page. */
router.get('/', isAuthenticated, function(req, res, next) {  
  req.flash('errorMessage', 'Username not existent');

  res.render('settings', { title: 'Settings' });
});


module.exports = {
  settingsRouter: router,

  editUserSettings: (req, res) => {
    let username = req.user.username;
    let password = req.body.password;
    let confirmPassword = req.body.confirmPassword;
    let bio = " ";        
    if(password.localeCompare(confirmPassword) == 0){

      let checkUsernameQuery = "SELECT * FROM `user` WHERE username = '" + username + "'";

      db.query(checkUsernameQuery, [username], (err, rows) => {
        if (err) {
            return res.status(500).send(err);
        }
        if (rows.length > 0) {
          bcrypt.hash(password, 5, function(err, hash) {

            let createQuery = "UPDATE user SET password = '" + hash + "' WHERE username = '" + username + "'";

            if(!err){
              db.query(createQuery, (err, result) => {
                if (err) {
                  return res.status(500).send(err);
                }
                if (result.length > 0) {
                  // TODO: CHANGE THIS TO POPUP / ERROR
                  console.log('Username already exists');
                }
                else{
                  db.query(createQuery, (err, result) => {
                    if (err) {
                      return res.status(500).send(err);
                    }
                    res.redirect('/home');
                  });
                }
              });
            }
        });
        }
        else{
          console.log("USERNAME DOESN'T EXIST");          
        }
      });
    }
    else{
      // TODO: CHANGE THIS TO POPUP / ERROR
      console.log("Passwords are different!");        
    }
  },
};