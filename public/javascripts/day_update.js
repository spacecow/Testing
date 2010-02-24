$( function(){
	days = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
	$("select#class_month").live( "change", function(){
		year  = $("select#class_year :selected").val();
		month = $("select#class_month :selected").val();
		day   = $("select#class_day :selected").val();
		$("span#day").html( "("+days[new Date( year+"/"+month+"/"+day ).getDay()]+")" );
	});
	$("select#class_day").live( "change", function(){
		year  = $("select#class_year :selected").val();
		month = $("select#class_month :selected").val();
		day   = $("select#class_day :selected").val();
		$("span#day").html( "("+days[new Date( year+"/"+month+"/"+day ).getDay()]+")" );
	});
	$("select#class_year").live( "change", function(){
		year  = $("select#class_year :selected").val();
		month = $("select#class_month :selected").val();
		day   = $("select#class_day :selected").val();
		$("span#day").html( "("+days[new Date( year+"/"+month+"/"+day ).getDay()]+")" );
	});	
});