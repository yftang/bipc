// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function() {
  $.each($("table#customers-table input[type='checkbox']"), function(i,e) {
    $(this).change(function() {
      if($(this).is(":checked")) {
        $("button#destroy-customers").attr("disabled", false);
      }
    });
  });
});

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


