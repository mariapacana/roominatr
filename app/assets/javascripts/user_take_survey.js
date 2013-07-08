$(document).ready(function(){

  $('#new_survey_button').on('ajax:success', function(event, data, status, xhr) {
    console.log(data.submission_form);
    $('#new_survey').html(data.submission_form);
  });

  $('#new_survey').on('ajax:success', '#create_submission', function(event, data, status, xhr) {
    if (data.new_submission) {
      $('#submission_list').append($(data.new_submission));
      $('#blank').html('<%= escape_javascript(render :partial => "show_progress") %>');
      $('#new_survey').empty();
    } else {
      $('#new_survey').html(data.submission_form);
    }
  });
});
