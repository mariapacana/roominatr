$(document).ready(function(){

  $('#get_users').on('ajax:success', function(event, data, status, xhr){
    $(this).html(data);
    console.log(data);
  });

});
