// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function () {
  $('div#project-procedures div.procedure a').click(function() {
    showProcedureDetail(this);
  });
});

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
