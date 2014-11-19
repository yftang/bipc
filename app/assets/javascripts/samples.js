// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function() {
  projectAccs = $('.project-objects').data('projects');
  $('input#sample_project').autocomplete({ source: projectAccs });

  $.each($("table#samples-table input[type='checkbox']"), function(i,e) {
    $(this).change(function() {
      if($(this).is(":checked")) {
        $("button#destroy-samples").attr("disabled", false);
      }
    });
  });

  $('.btn-project').on('click', function(event) {
    project_acc = $(this).text().trim();
    sample_id = $(this).attr("data-sample-id");
    $.ajax({
      type: "POST",
      url:  "/samples/delete_project",
      data: "id="+sample_id+"&project_acc="+project_acc,
      success: function(data) {
        alert(data.info);
      }
    });
  });
});

function destroy_samples() {
  selected_checks = $("table#samples-table input:checked");
  confirmed = confirm("Are you sure to remove thoses " +
                      selected_checks.length+" sample(s)?")
  if(confirmed == true) {
    $.each(selected_checks, function(i, e) {
      sample_id = $(this).val();
      $.ajax({
        type: "DELETE",
        url:  "/samples/"+sample_id
      });
    });
    location.reload();
  }
}
