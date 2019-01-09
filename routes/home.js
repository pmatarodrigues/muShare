var express = require('express');
var router = express.Router();

var musicList = {};

/* GET home page. */
router.get('/', function(req, res, next) {

    db.query('SELECT * FROM `music`', function(err, result) {

        if(err){
            throw err;
        } else {
            musicList = {musicList: result};
            console.log(musicList);
            
            res.render('home', { title: 'muShare', 'musicList': musicList });      
        }
    });
});


module.exports = {
    router: router,

    userLogout: (req, res) => {  

        let checkUserLoggedIn = "SELECT username FROM `user` WHERE login = 1";
    
        db.query(checkUserLoggedIn, (err, result) => {
            if (err) {
                return res.status(500).send(err);
            }

            console.log(result[0].username);
            

            let changeUserLogoutStatus = "UPDATE `user` SET login = 0 WHERE username = '" + result[0].username + "'";
    
            db.query(changeUserLogoutStatus, (err, result) => {
                if (err) {
                    return res.status(500).send(err);
                }                
            });            
        });
    },

    uploadMusic: (req, res) => {
        let checkUserLoggedIn = "SELECT username FROM `user` WHERE login = 1";
    
        db.query(checkUserLoggedIn, (err, result) => {
            if (err) {
                return res.status(500).send(err);
            }            

            let changeUserLogoutStatus = 'INSERT INTO `music`(name, duration, user) VALUES("' + req.body.musicname + '","' + req.body.musicduration +
             '","' + result[0].username + '")';
    
            db.query(changeUserLogoutStatus, (err, result) => {
                if (err) {
                    return res.status(500).send(err);
                }
                
                res.redirect('/home');
            });
    
            
        });
    }
}    


