$(document).ready(function(){
  $('.home-stream').bind('DOMSubtreeModified', function(e) {
    if (e.target.innerHTML.length > 0) {
      $('div[data-promoted]').each(function(){
        $(this).remove();
      });
    }
  });
});
