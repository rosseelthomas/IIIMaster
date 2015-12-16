
var socket_io = require("socket.io");
var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var routes = require('./routes/index');
var users = require('./routes/users');
process.env.PORT = 80;
var app = express();


var io = socket_io();
app.io = io;

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);
app.use('/users', users);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;

users = [];

io.on("connection",function(socket){

  console.log("connected");

  socket.on("msg",function(message){

    message.chain = escapeHtml(message.chain);
    message.alias = escapeHtml(message.alias);
    message.msg = escapeHtml(message.msg);

    if(message.chain=="ALL"){
      socket.broadcast.emit("usr_msg",{"chain":message.chain,"alias":socket.alias,"txt":message.msg});
    }else{
      s = findsocket(message.chain);
      s.emit("usr_msg",{"chain":socket.alias,"alias":socket.alias,"txt":message.msg});
    }
    socket.emit("usr_msg",{"chain":message.chain,"alias":socket.alias,"txt":message.msg});
    console.log("new message: "+message.msg+ " from "+socket.alias + " at "+message.chain);
  });

  socket.on("join",function(alias){
    alias = deleteIllegalchars(alias);
    while(findsocket(alias)){
      alias = alias+"_";
    }

    socket.alias = alias;
    users.push(socket);
    console.log("user joined : "+alias);

    socket.broadcast.emit("user_join", socket.alias);

    socket.emit("your_alias",alias);
    users.forEach(function(s){


        socket.emit("user_join",s.alias);


    });



  });

  socket.on("disconnect",function(msg){

    console.log(socket.id,"disconnected");

    for(i=0;i<users.length;++i){
        if (users[i] == socket){
          break;
        }
    }

    users.splice(i,1);

    socket.broadcast.emit("usr_left",socket.alias);


  });

});

function findsocket(usr){
  for(i=0;i<users.length;++i){
      if (users[i].alias == usr){
        return users[i];
      }
  }
  return 0;
}

var entityMap = {
   "&": "&amp;",
   "<": "&lt;",
   ">": "&gt;",
   '"': '&quot;',
   "'": '&#39;',
   "/": '&#x2F;'
 };

 function escapeHtml(string) {
   return String(string).replace(/[&<>"'\/]/g, function (s) {
     return entityMap[s];
   });
 }

 function deleteIllegalchars(string){
   return String(string).replace(/[&<>"'\/\s]/g, "");
 }
