$(document).ready(function(){

  //This handles both editing AND deleting at once and probably ought to be refactored.
  $('#submission_list').on('ajax:success','.submission', function(event, data, status, xhr){
    var index = $('.submission').index($(this));
    if (data.submission_form) {
      $('.submission').eq(index).html(data.submission_form);
    } else {
      $('.submission').eq(index).remove();
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
