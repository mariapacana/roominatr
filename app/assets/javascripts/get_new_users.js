$(document).ready(function(){

  $('#get_users').on('ajax:success', function(event, data, status, xhr){
    $('#users').html(data.show_users);
  });



});
