// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/*jQuery.fn.submitWithAjax = function(){
	this.submit(function(){
  	$.post($(this).attr("action"), $(this).serialize(), null, "script" );
  	return false;
  })
}*/

$(document).ready(function(){
  $("#new_comment").submit(function(){
  	$.post($(this).attr("action"), $(this).serialize(), null, "script" );
  	return false;
  })
  $("input.focus:last").focus();
})

$(document).ready(function() {
	// focus on the first text input field in the first field on the page
  $(":text:visible:enabled:first").focus();
});

/*
$(document).ready(function(){
  $("a#edit_comment").click( function(){
		$.ajax({
      url: this.href,
      dataType: "script",
      beforeSend: function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");},
    });
		return false;
  })
})
*/