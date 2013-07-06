$(document).ready(function(){

  $('#new_survey_button').on('ajax:success', function(event, data, status, xhr) {
    $('#new_survey').html(data.submission_form);
    bindSubmissionForm();
  });

  var bindSubmissionForm = function () {
    $('#create_submission').on('ajax:success', function(event, data, status, xhr) {
      console.log("WE RENDERED THE THING");
      $('#submission_list').append($(data.new_submission));
      $('#new_survey').empty();
    });
  }
});
