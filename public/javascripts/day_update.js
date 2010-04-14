$( function(){
	days = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
	$("select#menu_month").live( "change", function(){
		year  = $("select#menu_year :selected").val();
		month = $("select#menu_month :selected").val();
		day   = $("select#menu_day :selected").val();
		$("span#day").html( "("+days[new Date( year+"/"+month+"/"+day ).getDay()]+")" );
	});
	$("select#menu_day").live( "change", function(){
		year  = $("select#menu_year :selected").val();
		month = $("select#menu_month :selected").val();
		day   = $("select#menu_day :selected").val();
		$("span#day").html( "("+days[new Date( year+"/"+month+"/"+day ).getDay()]+")" );
	});
	$("select#menu_year").live( "change", function(){
		year  = $("select#menu_year :selected").val();
		month = $("select#menu_month :selected").val();
		day   = $("select#menu_day :selected").val();
		$("span#day").html( "("+days[new Date( year+"/"+month+"/"+day ).getDay()]+")" );
	});	
});