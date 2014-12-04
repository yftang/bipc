// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function() {
  projectAccs = $('.project-objects').data('projects');
  selection_input = $('input#sample_project');

  $('input#sample_project').autocomplete({
    source: projectAccs,
    select: function(event, ui) {
      sample_id = selection_input.attr("data-sample-id");
      project_acc = ui.item.value;
      $.ajax({
        type: "POST",
        url:  "/samples/add_project",
        data: "id="+sample_id+"&project_acc="+project_acc,
        success: function(data) {
          if(data.success == true) {
            selection_input.val("");
            btn_element = "<button class='btn btn-primary btn-project' type='button'>"+project_acc+"<span aria-hidden class='glyphicon glyphicon-remove'></span></button>";
            $('div#projects').append(btn_element);
          }else {
            alert(data.info);
          }
        }
      });
    }
  });

  $.each($("table#samples-table input[type='checkbox']"), function(i,e) {
    $(this).change(function() {
      if($(this).is(":checked")) {
        $("button#destroy-samples").attr("disabled", false);
      }
    });
  });

});

$(document).on('click', '.btn-project', function() {
  btn_element = $(this);
  project_acc = btn_element.text().trim();
  sample_id = selection_input.attr("data-sample-id");
  $.ajax({
    type: "POST",
    url:  "/samples/delete_project",
    data: "id="+sample_id+"&project_acc="+project_acc,
    success: function(data) {
      if(data.success == true) {
        btn_element.remove();
      }else {
        alert(data.info);
      }
    }
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
