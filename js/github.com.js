$(document).ready(function() {
  $(".file > .meta > .actions").each(function() {
    var diff = $(this).parent().parent();
    var link = $("<a href=\"#\" class=\"minibutton\">Hide</a>");
    $(this).prepend(link);
    link.click(function() {
      var codeArea = $(diff).find('[class$="wrapper"]');
      $(this).html() == 'Hide' ? codeArea.hide() : codeArea.show()
      $(this).html($(this).html() == 'Show' ? 'Hide' : 'Show');
      return false;
    });
  });
});
