// This requests html for rendering different template layouts whenever a user toggles
// a different template to use in campaign creation
$(function() {
  $(".template_selector").change(function() {
    var template_id = $(this).val();
    $.ajax({
      url: '../templates/show_form/' + template_id,
      method: 'get'
    }).done(function(data) {
      $('#widget_location').html(data);
    })
  })
});