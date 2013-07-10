$(document).ready(function(){

  $('#search_no_house_button').on('ajax:success', function(event, data, status, xhr){
    console.log("hey");
    $('#search_fields').html(data.no_house);
  });

  $('#search_house_button').on('ajax:success', function(event, data, status, xhr){
    console.log(data.house);
    $('#search_fields').html(data.house);
  });


});