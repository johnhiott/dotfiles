$(document).ready(function() {
  $(".diff-file > .diff-header > .diff-btn-group").each(function() {
    var diff = $(this).parent().parent();
    var link = $("<a href=\"#\" class=\"btn btn-small\">Hide</a>");
    $(this).prepend(link);
    link.click(function() {
      var codeArea = $(diff).find(".diff-content");
      $(this).html() == 'Hide' ? codeArea.hide() : codeArea.show()
      $(this).html($(this).html() == 'Show' ? 'Hide' : 'Show');
      return false;
    });
  });
});
