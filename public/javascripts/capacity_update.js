$( function(){
	$("span#course select").live( "change", function(){
		if( $("span#course select :selected").text().split(' ')[1] == "I" )
			$("span#capacity input").val("8");
		else
			$("span#capacity input").val("6");
	});
});