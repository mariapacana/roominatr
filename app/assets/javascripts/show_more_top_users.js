$(document).ready(function(){

  $('.top_users_form').on('ajax:success', function(event, data, status, xhr){
    console.log(data.more_users);
    console.log("hey");
  });

});


