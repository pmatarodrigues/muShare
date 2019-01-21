var express = require('express');
var router = express.Router();
var fileupload = require('express-fileupload');
var howler = require('howler');

var musicList = {};


function isAuthenticated(req, res, next) {
    if (req.isAuthenticated())
        return next();
    res.redirect('/');
}


/* GET home page. */
router.get('/', isAuthenticated, function(req, res, next) {

    db.query('SELECT name, duration, music, (SELECT username FROM user WHERE id = user) as username, (SELECT pic FROM user WHERE id = user) as pic FROM `music` ORDER BY dateUpload DESC', function(err, result) {
        if(err){
            throw err;
        } else {
            musicList = {musicList: result};                        
            res.render('home', { title: 'Home', 'musicList': musicList, user: req.user, onlineUser: req.user.username});      
        }
    });
});


module.exports = {
    router: router,

    uploadMusic: (req, res) => {   
        var username = req.user.username;
        var file = req.files.music;        
        var musicName = file.name;     
        let checkUsernameQuery = "SELECT * FROM `user` WHERE username = '" + username + "'";
        let createQuery;
        if(file.mimetype == "audio/mp3" || file.mimetype == "audio/wav" || file.mimetype == "audio/mpeg" ){
                       
            file.mv('public/music/'+ file.name, function(err) {                      
                if (err)
                return res.status(500).send(err);                  
                db.query(checkUsernameQuery, [username], (err, rows) => {
                    if (err) {
                        return res.status(500).send(err);
                    }
                    if (rows.length > 0) {    
                        if(req.files){
                            uploadQuery = 'INSERT INTO `music`(name, user, music) VALUES("' + musicName + '", (SELECT id FROM user WHERE username = "' + req.user.username + '")' + ',"' + musicName +'")'
                              
                        if(!err){
                            db.query(uploadQuery, (err, result) => {
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
            res.render('home',{message: message});
        }

    },

    

    play: () => {
        var sound = new Howl({
            urls: ['music/boombiple.wav']
        }).play();
    }
}    


