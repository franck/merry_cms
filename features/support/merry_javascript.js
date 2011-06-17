$(function() {
  
  $("div.cucumber").prepend("<p><a id='toggle-all' href='#'>voir tous les scénarios</a></p>")
  
  $("h3").before("<a class='show-scenario' href='#'>+</a>")
  $("h3").after("<div class='clear'></div>")
  $("li div:contains('Lorsque')").css("margin-top", "0.5em");
  $("li div:contains('Alors')").css("margin-top", "0.5em");
  
  
  $('ol').each(function(i) {
    $(this).addClass("scenario_" + i);
  });
  
  $('a.show-scenario').each(function(i) {
    $(this).click(function(){
      $('ol.scenario_' + i).toggle('400');
      return false;
    });
  });
  
  $('a#toggle-all').click(function(){
    $('ol').toggle('400');
    return false;
  });
  
});


