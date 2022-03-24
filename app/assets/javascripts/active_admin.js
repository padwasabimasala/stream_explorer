//= require active_admin/base

$( document ).ready(function() {
  $(".panel.hidable").click(function() {
    $(this).toggleClass("hidable-hidden")
    $(this).toggleClass("hidable-revealed")
  });
});
