$( function(){
	$("select#template_class_course_id").live( "change", function(){
		if( $("select#template_class_course_id :selected").text().split(' ')[1] == "I" )
			$("input#template_class_capacity").val("8");
		else
			$("input#template_class_capacity").val("6");
	});
});