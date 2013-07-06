$(document).ready(function(){

  $('#new_survey_button').on('ajax:success', function(event, data, status, xhr) {
    console.log(data);
    $('#new_survey').html(data.submission_form);
  });

});
