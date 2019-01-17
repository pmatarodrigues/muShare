var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var mysql = require('mysql');
var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;
var session = require('express-session');
var passportSocketIo = require('passport.socketio');
const bcrypt = require('bcrypt');
var dotenv = require('dotenv').config();
var flash = require('req-flash');
var fileupload = require("express-fileupload");
var multer  = require('multer');

var app = express();

// IMPORT FUNCTIONS FROM FILE
var indexRouter = require('./routes/index');
// var usersRouter = require('./routes/users');
var {settingsRouter, editUserSettings, uploadProfilePic} = require('./routes/settings');
const {userCreate, userLogin} = require('./routes/user')
const {router, userLogout, uploadMusic} = require('./routes/home');
var profileRouter = require('./routes/profile');

var upload = multer({ dest: 'public/images/profilepics' });

const db = mysql.createConnection({
  host: "localhost",
  user: "pedro",
  password: 'pedro',
  database: "muShare"
});
  
// CONNECT TO DATABASE
db.connect((err) => {
  if (err) {
      throw err;
  }
  console.log('Connected to DB');
});
global.db = db;

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'hbs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(fileupload());

// SESSION MANAGEMENT
app.use(session({
  name: 'LOGINSESSION',
  secret: process.env.SESSION_SECRET,
  resave: true,
  saveUninitialized: true,
  cookie: {
    maxAge: 60000
  }
}));
app.use(passport.initialize());
app.use(passport.session());


app.use('/', indexRouter);
app.use('/index', indexRouter);
// app.use('/users', usersRouter);
app.use('/home', router);
app.use('/settings', settingsRouter);
app.use('/profile', profileRouter);


// ASSOCIATE POSTS TO EACH FUNCTION
app.post('/create', userCreate);
app.post('/upload', uploadMusic);
app.post('/changeSettings', editUserSettings);
app.post('/uploadProfilePic', upload.single('pic'), uploadProfilePic);

app.post('/logout', function(req, res){
  req.logout();
  res.redirect('/');
});
app.post("/login", passport.authenticate('local', {
  successRedirect: '/home',
  failureRedirect: '/',
  failureFlash: true
}), function(req, res, info){

});

// USER SESSIONS MANAGEMENT
passport.use('local', new LocalStrategy({
  usernameField: 'username',
  passwordField: 'password',
  passReqToCallback: true //passback entire req to call back
} , function (req, username, password, done){
      if(!username || !password ) { return done(null, false, console.log('All fields are required.')); }    

      db.query("select * from user where username = ?", [username], function(err, rows){
        console.log(err);
        if (err) return done(req.flash('message',err));

        if(!rows.length){ return done(null, false, console.log('Invalid username or password.')); }

        var dbPassword  = rows[0].password;
        // CHECK IF PASSWORD IS CORRECT (AGAINST ENCRYPTED DB PASSWORD)
        bcrypt.compare(password, dbPassword, function(err, res) {
          if(!err){
              if(!res){
                return done(null, false, console.log('Invalid username or password.'));
              }
              else{
                return done(null, rows[0]);
              }
          }
        });
      });
    }
));
passport.serializeUser(function(user, done){
  done(null, user.id);
});
passport.deserializeUser(function(id, done){
  db.query("select * from user where id = "+ id, function (err, rows){
      done(err, rows[0]);
  });
});

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});



module.exports = app;
