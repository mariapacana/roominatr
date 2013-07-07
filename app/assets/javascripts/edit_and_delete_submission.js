$(document).ready(function(){

  $('#submission_list').on('ajax:success','.submission', function(event, data, status, xhr){
    var index = $('.submission').index($(this));
    $('.submission').eq(index).html(data.submission_form);
  });

  $('#submission_list').on('ajax:success', '.update_submission', function(event, data, status, xhr){
    if (data.updated_submission) {
      $(this).parent().replaceWith(data.updated_submission);
    } else {
      $(this).replaceWith(data.submission_form);
    }
  });

});
