function validateCreate(){
    var pass = document.getElementById("password");
    var cpass = document.getElementById("confPassword");
    var diffPass = document.getElementById("pass");

   

    if(pass.value != cpass.value){
        diffPass.innerHTML = "Passwords are not equal!";
        return false;
    }else{
        return true;
    }

}

