@index
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"

Scenario: Index view
Given a user is logged in as "johan"
When I go to the klasses page
Then "class_month" should have options "January, February, March, April, May, June, July, August, September, October, November, December"
	And "class_day" should have options "1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31"
	And "class_year" should have options "2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020"
	And "class_month" should have no blank option	
	And "class_day" should have no blank option	
	And "class_year" should have no blank option		
 	And "January" should be selected in "class_month"
 	And "28" should be selected in "class_day"
 	And "2010" should be selected in "class_year"
When I select "February" from "class_month"
	And I select "15" from "class_day"
	And I select "2012" from "class_year"
	And I press "Go!"
Then I should be redirected to the klasses page
 	And "February" should be selected in "class_month"
 	And "15" should be selected in "class_day"
 	And "2012" should be selected in "class_year"
	
@index_links
Scenario Outline: Links from index page
Given a user is logged in as "johan"
When I go to the klasses page
When I select "<month>" from "class_month"
	And I select "<day>" from "class_day"
	And I select "<year>" from "class_year"
	And I press "Go!"
	And I follow "New Class" within "div#list div#links"
Then I should be redirected to the new klass page
	And "<year>" should be selected in "klass_date_1i"
	And "<month>" should be selected in "klass_date_2i"
	And "<day>" should be selected in "klass_date_3i"
	And "klass_date_1i" should have no blank option	
	And "klass_date_2i" should have no blank option	
	And "klass_date_3i" should have no blank option	
Examples:
|	year	|	month			|	day	|
|	2012	|	February	|	15	|
|	2020	|	December	|	1		|
|	2010	|	January		|	31	|

Scenario: Let day have appear with AJAX so its easier to get the date right (NOT IMPLEMENTED)
Given not implemented

Scenario: Each part of the date must be coded so they have the same code for each language (NOT IMPLEMENTED)
Given not implemented
