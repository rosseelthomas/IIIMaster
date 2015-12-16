users = ["ALL"];

var history = {};

var socket =io();
$(document).ready(function(){

  alias="";
  while(alias==""){
    alias = window.prompt("geef een alias")
  }
  socket.emit("join",alias);

  adduser(users[0]);
  setactive(users[0]);


  socket.on("your_alias",function(al){
      alias = al;
      $("#header").html("ingelogd als <b>"+al+"</b>");
  });


  socket.on("user_join",function(name){
    adduser(name);
    users.push(name);
  });

  socket.on("usr_msg",function(msg){

console.log("usr_msg",msg);

    if(msg.chain==currentchat()){
      putmsg(msg.alias,msg.txt);
    }else{
      if(!history[msg.chain]){
        history[msg.chain] = [];
      }
      history[msg.chain].push(msg);

      count = getcount(msg.chain);
      if(count!=""){
        count++;
      }else{
        count = 1;
      }

      setcount(msg.chain,count);
    }

  });

  socket.on("usr_left",function(name){


      active = currentchat();
      if(name==currentchat()){
        active = users[0];
      }



      for(i=0;i<users.length;++i){
        if(users[i]==name) break;
      }
      users.splice(i,1);

      $("#users").text("");
      users.forEach(function(al){
        adduser(al);

      });


      setactive(active);

  });




});

function fsub(){
  var txt = $("#txt").val();
  $("#txt").val("");
  if(txt.length>0 ){
    //putmsg(alias,txt);
    socket.emit('msg', {"chain":currentchat(), "msg":txt});
  }

    return false;
}

function adduser(usr){
  if(usr!=alias){

    $("#users").append("<a id=\"chat-"+usr+"\" href=\"#\" class=\"list-group-item\"><span class=\"badge\"></span>"+usr+"</a>");
    clickbind(usr);

  }else{


    $("#users").append("<a id=\"chat-"+usr+"\" href=\"#\" class=\"list-group-item disabled\"><span class=\"badge\"></span>"+usr+"</a>");

  }
}

function setactive(usr){
  $("#users > a").removeClass("active");
  $("#chat-"+usr).addClass("active");
}

function currentchat(){
  return $(".active").attr('id').substr(5);
}

function clickbind(usr){
  $("#chat-"+usr).click(function(l) {

    u = $(l.toElement).attr('id').substr(5);
    if(u!=currentchat()){
      setactive(u);
      $("#chat").text("");

      if(history[u]){
        history[u].forEach(function(msg){
            putmsg(msg.alias,msg.txt);

        });

        history[u] = [];
      }

      setcount(u,"");
    }

  });
}

function putmsg(a,t){

  $("#chat").append("<b>"+a+":</b>  "+t+"<br />");
  $("#chat").animate({
    scrollTop: $("#chat").height()
}, 300);
}

function getcount(usr){
  return $("#chat-"+usr+" span").text();
}

function setcount(usr,count){
  $("#chat-"+usr+" span").text(count);
}
