$(document).ready(function(){

  $('.top_users_form').on('ajax:success', function(event, data, status, xhr){
    $(this).before(data.more_users);
    formAction = $(this).attr('action');
    console.log(formAction);
    pageNum = (/\d+/).exec(formAction);
    newPageNum = String(Number(pageNum)+1);
    console.log(newPageNum);
    newFormAction = formAction.replace(/(\d+)/,newPageNum);
    console.log(newFormAction);
    $(this).attr('action', newFormAction);
  });

});


