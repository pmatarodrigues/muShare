var express = require('express');
var router = express.Router();
var bcrypt = require('bcrypt');
var fileupload = require("express-fileupload");


function isAuthenticated(req, res, next) {
  if (req.isAuthenticated())
    return next();
  res.redirect('/');
}

/* GET home page. */
router.get('/', isAuthenticated, function(req, res, next) {  
  res.render('settings', { title: 'Settings' });
});


module.exports = {
  settingsRouter: router,

  // FUNCTION FOR USER TO CHANGE HIS PROFILE PIC
  uploadProfilePic: (req, res) => {
    var username = req.user.username;
    var file = req.files.pic;
    var picname = file.name;     
    let checkUsernameQuery = "SELECT * FROM `user` WHERE username = '" + username + "'";
    let createQuery;
    if(file.mimetype == "image/jpeg" ||file.mimetype == "image/png"||file.mimetype == "image/gif" ){
                                
      file.mv('public/images/profilepics/'+file.name, function(err) {                      
        if (err)
          return res.status(500).send(err);                  
          db.query(checkUsernameQuery, [username], (err, rows) => {
            if (err) {
                return res.status(500).send(err);
            }
            if (rows.length > 0) {    

                if(req.files){
                  createQuery = "UPDATE user SET pic = '" + picname + "' WHERE username = '" + username + "'";                   
                  if(!err){
                    db.query(createQuery, (err, result) => {
                      if (err) {
                        return res.status(500).send(err);
                      }
                      res.redirect('/home');                    
                    });
                  }
                }             
            }
            else{
              console.log("USERNAME DOESN'T EXIST");          
            }
          });
      });
    } else {
      message = "This format is not allowed , please upload file with '.png','.gif','.jpg'";
      res.render('index.ejs',{message: message});
    }

  },

  // FUNCTION FOR USER TO CHANGE HIS PASSWORD
  editUserSettings: (req, res) => {    

    let username = req.user.username;
    let password = req.body.password;
    let confirmPassword = req.body.confirmPassword;
    //let pic = req.body.pic;
    let bio = " ";                   

    if(password.localeCompare(confirmPassword) == 0){

      let checkUsernameQuery = "SELECT * FROM `user` WHERE username = '" + username + "'";
      let createQuery;
   
      db.query(checkUsernameQuery, [username], (err, rows) => {
        if (err) {
            return res.status(500).send(err);
        }
        if (rows.length > 0) {
          bcrypt.hash(password, 5, function(err, hash) {

            if(password.length > 0 && req.files){
              createQuery = "UPDATE user SET pic = '" + picname + "', password = '" + hash + "' WHERE username = '" + username + "'";
            }
            else if(password.length > 0 && !req.files){
              createQuery = "UPDATE user SET password = '" + hash + "' WHERE username = '" + username + "'";                      
            }else{
              createQuery = "UPDATE user SET pic = '" + picname + "' WHERE username = '" + username + "'"; 
            }

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