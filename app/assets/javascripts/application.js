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
//= require bootstrap-datepicker/core
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
});


