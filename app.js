var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var mysql = require('mysql');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
const {router, userLogout} = require('./routes/home');

var app = express();

// IMPORT FUNCTIONS FROM FILE
const {userCreate, userLogin} = require('./routes/user')

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

app.use('/', indexRouter);
app.use('/index', indexRouter);
app.use('/users', usersRouter);
app.use('/home', router);

// ASSOCIATE POSTS TO EACH FUNCTION
app.post('/create', userCreate);
app.post('/login', userLogin);
app.post('/logout', userLogout);


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
