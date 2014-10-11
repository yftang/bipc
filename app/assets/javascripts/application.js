// This is a manifest file that"ll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/dialog
//= require jquery-ui/effect-fade
//= require jquery-ui/effect-shake
//= require jquery-ui/autocomplete
//= require bootstrap-datepicker
//= require bootstrap-sprockets
//= require_tree .
$(document).ready(function() {
  $(".alert").fadeOut(3000);

  $("input.datepicker").datepicker({
    format: "yyyy-mm-dd",
    autoclose: true,
    todayHighlight: true,
    todayBtn: true
  });

  $.each($("table#users-table input[type='checkbox']"), function(i,e) {
    $(this).change(function() {
      if($(this).is(":checked")) {
        $("button#destroy-users").attr("disabled", false);
      }
    });
  });
  $.each($("table#projects-table input[type='checkbox']"), function(i,e) {
    $(this).change(function() {
      if($(this).is(":checked")) {
        $("button#destroy-projects").attr("disabled", false);
      }
    });
  });

  $.each($("table#customers-table input[type='checkbox']"), function(i,e) {
    $(this).change(function() {
      if($(this).is(":checked")) {
        $("button#destroy-customers").attr("disabled", false);
      }
    });
  });

  $.each($("table#samples-table input[type='checkbox']"), function(i,e) {
    $(this).change(function() {
      if($(this).is(":checked")) {
        $("button#destroy-samples").attr("disabled", false);
      }
    });
  });

  $("form#sign_in_user")
    .bind("ajax:success", function(e, data, status, xhr) {
      if(data.success == true) {
        submitBtn = $("form#sign_in_user input[name='commit']");
        submitBtn.removeClass("btn-primary");
        submitBtn.addClass("btn-success");
        submitBtn.prop("value", "Done");
        setTimeout(function(){location.reload();}, 1000);
      }else {
        $.each($("form#sign_in_user .form-group"), function(i, e){
          $(this).addClass("has-error");
        });
        $("#login-modal").effect("shake", {direction: "right"});
      }
    });

  $("form#new_user")
    .bind("ajax:success", function(e, data, status, xhr) {
      if(data.success == true) {
        submitBtn = $("form#new_user input[name='commit']");
        submitBtn.removeClass("btn-primary");
        submitBtn.addClass("btn-success");
        submitBtn.prop("value", "Done");
        setTimeout(function(){location.reload();}, 1000);
      }else {
        $.each($("form#new_user .form-group"), function(i, e){
          $(this).addClass("has-error");
        });
        $("#new-user-modal").effect("shake", {direction: "right"});
      }
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
              "<a href='/users/"+user_id+"'>"+user_name+"</a>");
          }
        }
      });
    }
  });
});

function set_checkbox(obj) {
  tmp_class = $(obj).attr("class");
  tmp_select = $("select[name="+tmp_class+"]").clone()
    .removeClass("hidden").addClass("action")
  $(obj).replaceWith(tmp_select);
}

function destroy_users() {
  selected_checks = $("table#users-table input:checked");
  confirmed = confirm("Are you sure to remove thoses " +
                      selected_checks.length+" user(s)?")
  if(confirmed == true) {
    $.each(selected_checks, function(i, e) {
      user_id = $(this).val();
      $.ajax({
        type: "DELETE",
        url:  "/users/"+user_id
      });
    });
    location.reload();
  }
}

function destroy_customers() {
  selected_checks = $("table#customers-table input:checked");
  confirmed = confirm("Are you sure to remove thoses " +
                      selected_checks.length+" customer(s)?")
  if(confirmed == true) {
    $.each(selected_checks, function(i, e) {
      customer_id = $(this).val();
      $.ajax({
        type: "DELETE",
        url:  "/customers/"+customer_id
      });
    });
    location.reload();
  }
}

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
function search_projects() {
  query_acc = $("input#query").val();
  jQuery.get("/projects/search_projects",
        { search_project_acc: query_acc },
        function(data) {
          if(data == null) {
            $("#projects_list").html("<p>Project not found.</p>");
          }else {
            insert_html = "";
            jQuery.each(data, function() {
              insert_html += "<a href='/projects/"+this.id+"'>"+this.acc+"</a>\n";
            });
            $("#projects_list").html(insert_html);
          }
        }
  );
  $("#search_result").dialog({
    title: "Search result",
    modal: true,
    width: 500,
    close: function() {
      $("#projects_list").html("");
      $("#search_result").dialog("destroy");
    }
  });
}
