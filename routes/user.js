

module.exports = {

    userCreate: (req, res) => {
        let username = req.body.username;
        let password = req.body.password;
        let confirmPassword = req.body.confirmPassword;
        let bio = " ";        
        if(password.localeCompare(confirmPassword) == 0){

            let checkUsernameQuery = "SELECT * FROM `user` WHERE username = '" + username + "'";
            let createQuery = "INSERT INTO `user`(username, password, bio, login) VALUES('" + username + "','" + password + "','" + bio + "','0')";

            db.query(checkUsernameQuery, (err, result) => {
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
                        res.redirect('/');
                    });
                }
            });
        }
        else{
            // TODO: CHANGE THIS TO POPUP / ERROR
            console.log("Passwords are different!");
            
        }
    }
}
