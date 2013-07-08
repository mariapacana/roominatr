var Bar = function(numUserSubmissions, totalSurveys){
  this.numUserSubmissions = numUserSubmissions;
  this.totalSurveys = totalSurveys;

  this.percentage = function() {
    var percentage = ((this.numUserSubmissions/this.totalSurveys).toFixed(2)*100).toString()+'%';
    return percentage;
  }

  this.upMeter = function(){
    this.numUserSubmissions++;
    $('.meter span').css('width', this.percentage());
  }

  this.downMeter = function(){
    this.numUserSubmissions--;
    $('.meter span').css('width', this.percentage());
  }
};

$(document).ready(function(){

  $('#new_survey_button').on('ajax:success', function(event, data, status, xhr) {
    $('#new_survey').html(data.submission_form);
  });

  $('#new_survey').on('ajax:success', '#create_submission', function(event, data, status, xhr) {
    if (data.new_submission) {
      $('#submission_list').append($(data.new_submission));
      $('#new_survey').empty();
      bar.upMeter();
    } else {
      $('#new_survey').html(data.submission_form);
    }
  });

  //This handles both editing AND deleting at once and probably ought to be refactored.
  $('#submission_list').on('ajax:success','.submission', function(event, data, status, xhr){
    var index = $('.submission').index($(this));
    if (data.submission_form) {
      $('.submission').eq(index).html(data.submission_form);
    } else {
      $('.submission').eq(index).remove();
      bar.downMeter();
    }
  });

  $('#submission_list').on('ajax:success', '.update_submission', function(event, data, status, xhr){
    if (data.updated_submission) {
      $(this).parent().replaceWith(data.updated_submission);
    } else {
      $(this).replaceWith(data.submission_form);
    }
  });

});

