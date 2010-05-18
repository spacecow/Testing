$( function(){
	$("span#course select").live( "change", function(){
		$("span#capacity input").val( $("span#course select :selected").text().match(/\d/) );
	});
});