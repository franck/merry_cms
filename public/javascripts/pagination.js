$(document).ready(function() {

  //console.log('in pagination');

  $('#pagination_filter > select').bind('change', function(event){
    $('form')[0].submit();
  });

  
  $('#pagination_filter > :checkbox#active').bind('change', function(event){
    $('form')[0].submit();
  });

});
