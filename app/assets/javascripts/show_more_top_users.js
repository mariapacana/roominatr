$(document).ready(function(){

  $('.top_users_form').on('ajax:success', function(event, data, status, xhr){
    $("#top_users").before(data.more_users);
  });

});


