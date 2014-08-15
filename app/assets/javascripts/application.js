// This is a manifest file that'll be compiled into application.js, which will include all the files
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
//= require jquery-ui
//= require bootstrap-sprockets
//= require_tree .
$(document).ready(function() {
  $('.alert').fadeOut(3000);

  $('form#sign_in_user')
    .bind("ajax:success", function(e, data, status, xhr) {
      if(data.success == true) {
        submitBtn = $('form#sign_in_user input[name="commit"]');
        submitBtn.removeClass("btn-primary");
        submitBtn.addClass("btn-success");
        submitBtn.prop('value', 'Done');
        setTimeout(function(){location.reload();}, 1000);
      }else {
        $.each($('form#sign_in_user .form-group'), function(i, ele){
          $(this).addClass("has-error");
        });
        submitBtn = $('form#sign_in_user input[name="commit"]');
        submitBtn.effect("shake", {direction: "right"});
      }
    });
});

function search_projects() {
  query_acc = $('input#query').val();
  jQuery.get("/projects/search_projects",
        { search_project_acc: query_acc },
        function(data) {
          if(data == null) {
            $('#projects_list').html('<p>Project not found.</p>');
          }else {
            insert_html = '';
            jQuery.each(data, function() {
              insert_html += '<a href="/projects/'+this.id+'">'+this.acc+'</a>\n';
            });
            $('#projects_list').html(insert_html);
          }
        }
  );
  $('#search_result').dialog({
    title: 'Search result',
    modal: true,
    width: 500,
    close: function() {
      $('#projects_list').html('');
      $('#search_result').dialog('destroy');
    }
  });
}
