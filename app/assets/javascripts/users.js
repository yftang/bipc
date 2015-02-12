// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function() {
  $.each($("table#users-table input[type='checkbox']"), function(i,e) {
    $(this).change(function() {
      if($(this).is(":checked")) {
        $("button#destroy-users").attr("disabled", false);
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
});

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



