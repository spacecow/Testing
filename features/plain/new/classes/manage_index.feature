@index
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"

@allow-rescue
Scenario Outline: Some users cannot reach the list of classes
Given a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"
	And a user is logged in as "<user>"
When I go to the klasses page
Then I should be redirected to the events page
Examples:
|	user			|
| prince		|
| junko			|
| mika			|

Scenario: List classes for observer
Given a course: "ruby" exists with name: "Ruby I"
	And a klass: "ruby" exists with course: course "ruby", start_time: "18:50", end_time: "20:50", date: "2010-02-28"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user is logged in as "thomas"
When I go to the klasses page
	And I select "February" from "class_month"
	And I select "28" from "class_day"
	And I select "2010" from "class_year"
	And I press "Go!"
Then I should see options "Info" within "table#Ruby tr td#links"

Scenario: Classes display of date
Given a user is logged in as "johan"
When I go to the klasses page
Then "class_month" should have options "January, February, March, April, May, June, July, August, September, October, November, December"
	And "class_day" should have options "1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31"
	And "class_year" should have options "2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020"
	And "class_month" should have no blank option	
	And "class_day" should have no blank option	
	And "class_year" should have no blank option		
When I select "February" from "class_month"
	And I select "15" from "class_day"
	And I select "2012" from "class_year"
	And I press "Go!"
Then I should be redirected to the klasses page
 	And "February" should be selected in "class_month"
 	And "15" should be selected in "class_day"
 	And "2012" should be selected in "class_year"

Scenario: List classes according to day
Given a course: "ruby" exists with name: "Ruby I"
	And a course: "rails" exists with name: "Rails II"
	And a klass: "ruby" exists with course: course "ruby", start_time: "18:50", end_time: "20:50", date: "2010-02-28"
	And a klass: "rails" exists with course: course "rails", start_time: "12:00", end_time: "13:00", date: "2010-03-01"
	And a user is logged in as "johan"
When I go to the klasses page
	And I select "February" from "class_month"
	And I select "28" from "class_day"
	And I select "2010" from "class_year"
	And I press "Go!"
Then I should see "I" within "table#Ruby tr td.course_level"
	And I should see "18:50~20:50" within "table#Ruby tr td#time_interval"
	And I should see "" within "table#Ruby tr td#unit"
	And I should see "" within "table#Ruby tr td#classroom"
	And I should see "" within "table#Ruby tr td#teacher"
	And I should see options "Info, Edit, Del" within "table#Ruby tr td#links"
	And I should not see "Rails"
When I select "March" from "class_month"
	And I select "1" from "class_day"
	And I select "2010" from "class_year"
	And I press "Go!"
	And I should see "II" within "table#Rails tr td.course_level"
	And I should see "12:00~13:00" within "table#Rails tr td#time_interval"	
	And I should see "" within "table#Rails tr td#unit"
	And I should see "" within "table#Rails tr td#classroom"
	And I should see "" within "table#Rails tr td#teacher"
	And I should see options "Info, Edit, Del" within "table#Rails tr td#links"
	And I should not see "Ruby"

@index_links
Scenario Outline: Check that the date is correct in the form when creating a new class
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

@index_links
Scenario: Links from index page
Given a course exists with name: "Rails II"
	And a course exists with name: "Ruby II"
	And a course: "ruby1" exists with name: "Ruby I"
	And a klass exists with course: course "ruby1", start_time: "18:50", end_time: "20:50", date: "2010-02-28", capacity: 6
	And a user is logged in as "johan"
Then 1 klasses should exist
When I go to the klasses page
	And I select "February" from "class_month"
	And I select "28" from "class_day"
	And I select "2010" from "class_year"
	And I press "Go!"
	And I follow "Info" within "table#Ruby tr td#links"
Then I should be redirected to the show page of that klass
When I go to the klasses page
	And I select "February" from "class_month"
	And I select "28" from "class_day"
	And I select "2010" from "class_year"
	And I press "Go!"
	And I follow "Edit" within "table#Ruby tr td#links"
Then I should be redirected to the edit page of that klass
When I go to the klasses page
	And I follow "New Class" within "div#list div#links"
Then I should be redirected to the new klass page
	And the "Course" field should have options "BLANK, Ruby I, Ruby II, Rails II"
When I press "Create"
Then I should be redirected to the error klasses page
	And the "Course" field should have options "BLANK, Ruby I, Ruby II, Rails II"
When I press "Create"
Then I should be redirected to the error klasses page
	And the "Course" field should have options "BLANK, Ruby I, Ruby II, Rails II"	
When I go to the klasses page
	And I select "February" from "class_month"
	And I select "28" from "class_day"
	And I select "2010" from "class_year"
	And I press "Go!"
	And I follow "+" within "table#Ruby"
Then I should be redirected to the new klass page
	And the "Course" field should have options "BLANK, Ruby I, Ruby II"
	And the "Start time" field should be empty
	And the "End time" field should be empty
When I press "Create"
Then I should be redirected to the error klasses page
	And the "Course" field should have options "BLANK, Ruby I, Ruby II"
When I press "Create"
Then I should be redirected to the error klasses page
	And the "Course" field should have options "BLANK, Ruby I, Ruby II"	
When I go to the klasses page
	And I select "February" from "class_month"
	And I select "28" from "class_day"
	And I select "2010" from "class_year"
	And I press "Go!"
	And I follow "+" within that klass
Then I should be redirected to the klasses page
	And 2 klasses should exist
	And 2 klasses should exist with start_time: "18:50", end_time: "20:50", capacity: 6, date: "2010-02-28", course: course "ruby1"

Scenario: Let day have appear with AJAX so its easier to get the date right (NOT IMPLEMENTED)
Given not implemented

Scenario: Not be able to delete a class with students (NOT IMPLEMENTED)
Given not implemented