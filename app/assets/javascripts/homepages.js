// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function() {
  projectAccs = $('#project_objects').data('projects');
  $('input#go_to_project').autocomplete({
    source: projectAccs,
    select: function(event, ui) {
      $(this).val(ui.item.label);
      $(this).closest('form').submit();
    }
  });
});
