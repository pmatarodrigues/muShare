

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
    },

    userLogin: (req, res) => {
        let username = req.body.username;
        let password = req.body.password;

        let checkLoginUsername = "SELECT * FROM `user` WHERE username = '" + username + "'";
        let checkLoginPassword = "SELECT * FROM `user` WHERE username = '" + username + "' AND password = '" + password + "'";
        let changeUserLoginStatus = "UPDATE `user` SET login = 1 WHERE username = '" + username + "'";

        // CHECK IF USERNAME EXISTS / IS VALID
        db.query(checkLoginUsername, (err, result) => {
            if (err) {
                return res.status(500).send(err);
            }
            if (result.length == 0) {
                // TODO: CHANGE THIS TO POPUP / ERROR
                console.log('Invalid Username!');
            } else{
                // CHECK IF PASSWORD IS CORRECT FOR THE GIVEN USERNAME
                db.query(checkLoginPassword, (err, result) => {
                    if (err) {
                        return res.status(500).send(err);
                    }
                    if(result.length == 0) {
                        // TODO: CHANGE THIS TO POPUP / ERROR
                        console.log("Wrong Password!");                        
                    } else{

                        // IF EVERYTHING IS CORRECT, LOGIN
                        console.log("SUCCESS! \n");
                        // CHANGE LOGIN STATUS TO 1
                        db.query(changeUserLoginStatus, (err, result) => {
                            if (err) {
                                return res.status(500).send(err);
                            }
                            else{
                                res.redirect('/home');               
                            }
                        });
                    }
                });
            }

        });

    }
}
