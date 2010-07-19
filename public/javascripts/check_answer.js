$( function(){
	$("form").keypress( function(e){
		if( e.which == 13 ){
			$("input#answer").val("");
			return false;
		}
	});
	$("input#answer").live('keyup', function(e){
		var answer = $("input#answer").val();
		var part_answer = $("div#part").html();
		var correct_answer = $("div#correct").html();
		var regex = new RegExp( answer, "g" );
		var hit = correct_answer.replace(regex,answer.replace(/./g,"*"));
		
		var new_part_answer = ""
		for( var i=0; i<part_answer.length; i++ ){
			if( hit.charAt(i) == "*" ){
				new_part_answer += correct_answer.charAt(i);
			}else{
				new_part_answer += part_answer.charAt(i);
			}
		}

		$("div#part").html( new_part_answer );

		if( new_part_answer == correct_answer ){
			$("input#answer").val("skip");
			$("input#story_submit").click();
		}
		
		//alert(  );
		//alert( $("div#correct").html() );
		// answer.replace(/./g,"*")
//		var text = $("input#answer").val();
//		$("input#correct_answer").val( text );
//		//alert( text );
//		//alert( $("input#answer").val() ); 
	});
});