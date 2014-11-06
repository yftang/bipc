// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function () {
  $('div#project-procedures div.procedure a').click(function() {
    showProcedureDetail(this);
  });

  $.each($("table#projects-table input[type='checkbox']"), function(i,e) {
    $(this).change(function() {
      if($(this).is(":checked")) {
        $("button#destroy-projects").attr("disabled", false);
      }
    });
  });
});

$(document).on("change", "table#projects-table select.action", function() {
  select_tag = $(this);
  option_tag = $(this).find("option:selected");
  select_name = $(this).attr("name");
  set_action = select_name.replace("-", "_");
  user_name = option_tag.text();
  user_id = option_tag.attr("value");
  project_id = $(this).closest("tr").attr("id");
  if(user_name == "Select one") return false;
  confirmed = confirm("Are you sure to set "+user_name+"?");
  if(confirmed == true) {
    $.ajax({
      type: "POST",
      url:  "/projects/"+set_action,
      data: "id="+project_id+"&user_name="+user_name+"&user_id="+user_id,
      success: function(data) {
        if(data.success == true) {
          select_tag.closest("td").html(
            "<a href='/users/"+data.param+"'>"+user_name+"</a>");
        }
      }
    });
  }
});

function search_projects() {
  query_acc = $("input#query").val();
  jQuery.get(
    "/projects/search_projects",
    { search_project_acc: query_acc },
    function(data) {
      modal_body = $("#search_result .modal-body");
      modal_footer = $("#search_result .modal-footer");
      modal_body.empty();
      modal_footer.empty();
      if(data.length == 0) {
        modal_footer.append("<h4>No similar project found.</h4>");
      }else {
        jQuery.each(data, function() {
          modal_body.append(
            "<h4><a href='/projects/"+this.id+"'>"+this.acc+"</a></h4>\n"
          );
        });
        modal_footer.append("<h4>"+data.length+" project(s) found.</h4>");
      }
    }
  );
  $("#search_result").modal("show");
}

function destroy_projects() {
  selected_checks = $("table#projects-table input:checked");
  confirmed = confirm("Are you sure to remove thoses " +
                      selected_checks.length+" project(s)?")
  if(confirmed == true) {
    $.each(selected_checks, function(i, e) {
      project_id = $(this).val();
      $.ajax({
        type: "DELETE",
        url:  "/projects/"+project_id
      });
    });
    location.reload();
  }
}

function set_checkbox(obj) {
  tmp_class = $(obj).attr("class");
  tmp_select = $("select[name="+tmp_class+"]").clone()
    .removeClass("hidden").addClass("action")
  $(obj).replaceWith(tmp_select);
}


function showProcedureDetail(event_object) {
  switch(event_object.text) {
    case "Samples":
      $('div#procedure-details div').hide();
      $('div#procedure-details div#samples-procedure').show(500);
      break;
    case "Experiments":
      $('div#procedure-details div').hide();
      $('div#procedure-details div#experiments-procedure').show(500);
      break;
    case "Analysis":
      $('div#procedure-details div').hide();
      $('div#procedure-details div#analysis-procedure').show(500);
      break;
    case "Report":
      $('div#procedure-details div').hide();
      $('div#procedure-details div#report-procedure').show(500);
      break;
  }
}
