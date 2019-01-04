var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('home', { title: 'muShare' });
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
                
                res.redirect('/');
            });
    
            
        });
    }
}    


