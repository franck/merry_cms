$(function() {

  $('.required').append("<em>&nbsp;*</em>");
  
  $('#header').corner({
    tl: { radius: 12 },
    tr: { radius: 12 },
    bl: { radius: 0 },
    br: { radius: 0 }});
    
  $('.container').corner({
      tl: { radius: 0 },
      tr: { radius: 0 },
      bl: { radius: 12 },
      br: { radius: 12 }});
      
  $(':text:first').focus();
    
});
