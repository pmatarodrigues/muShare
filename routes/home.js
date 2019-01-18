var express = require('express');
var router = express.Router();
var moment = require('moment');

var musicList = {};


function isAuthenticated(req, res, next) {
    if (req.isAuthenticated())
        return next();
    res.redirect('/');
}


/* GET home page. */
router.get('/', isAuthenticated, function(req, res, next) {

    db.query('SELECT name, duration, (SELECT username FROM user WHERE id = user) as username, (SELECT pic FROM user WHERE id = user) as pic FROM `music` ORDER BY dateUpload DESC', function(err, result) {
        if(err){
            throw err;
        } else {
            musicList = {musicList: result};            
            musicListJSON =  JSON.stringify(musicList).replace(/"/g, '&quot;');        
            res.render('home', { title: 'Home', 'musicList': musicList, 'musicListJSON': musicListJSON, user: req.user });      
        }
    });
});


module.exports = {
    router: router,

    uploadMusic: (req, res) => {        

        // QUERY TO INSERT MUSIC ON DATABASE
        let insertMusic = 'INSERT INTO `music`(name, duration, user, music) VALUES("' + req.body.musicname + '","' + req.body.musicduration +
            '", (SELECT id FROM user WHERE username = "' + req.user.username + '")' + ',"' + req.body.music +'")';    
            
        db.query(insertMusic, (err, result) => {
            if (err) {
                return res.status(500).send(err);
            }                
            res.redirect('/home');
        });            
    }
}    


