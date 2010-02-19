$( function(){
	$("select#class_month").live( "change", function(){
		year  = $("select#class_year :selected").val();
		month = $("select#class_month :selected").val();
		day   = $("select#class_day :selected").val();
		days = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
		alert( days[new Date( year+"-"+month+"-"+day ).getDay()] );
	});
});