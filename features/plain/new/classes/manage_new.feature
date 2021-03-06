@new
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a course: "ruby" exists with name: "Ruby I", capacity: "8"
	And a course exists with name: "Fortran I", capacity: "8"
	And a course exists with name: "Rails II", capacity: "6"

@new_class
Scenario: Create a new class
Given a user is logged in as "johan"
When I go to the new klass page
	And I select "Ruby I (8)" from "Course"
	And I select "February 20, 2010" as the date
	And I fill in "Start time" with "13:00"
	And I fill in "End time" with "14:00"
	And I fill in "Capacity" with "8"
	And I fill in "Title" with "Did you know"
	And I fill in "Description" with "ishigani in Japanese"
	And I fill in "Note" with "is stone crab in English"
	And I press "Create"
Then I should automatically browse to the klasses page of "February 20, 2010"
	And I should see "Successfully created class."
	And a klass should exist with course: course "ruby", date: "2010-2-19 15", start_time: "13:00", end_time: "14:00", capacity: 8, title: "Did you know", description: "ishigani in Japanese", note: "is stone crab in English"
	And 1 klasses should exist

@new_view
Scenario: Class' new view
Given a user is logged in as "johan"
When I go to the new klass page
Then I should see "New Class" within "legend"
	And the "Course" field should have options "BLANK, Ruby I (8), Rails II (6), Fortran I (8)"
	And "" should be selected in the "Course" field
	#And "" should be selected in "klass_date_1i"
	#And "" should be selected in "klass_date_2i"
	#And "" should be selected in "klass_date_3i"
	And the "Start time" field should be empty
	And I should see "Ex. 17:50" within "li#klass_start_time_string_input"
	And the "End time" field should be empty
	And I should see "Ex. 18:40" within "li#klass_end_time_string_input"
	And the "Cancel" checkbox should not be checked
	And the "Capacity" field should contain ""
	And the "Title" field should be empty
	And the "Description" field should contain ""
	And the "Note" field should contain ""
	And I should see links "List Classes" at the bottom of the page
	
Scenario: Links from class' new page
Given a user is logged in as "johan"
When I go to the new klass page
	And I follow "List Classes" at the bottom of the page
Then I should be redirected to the klasses page

Scenario Outline: Only admins can create a class
	Given a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Junko Sumii"
	And a user is logged in as "<user>"
When I go to the new klass page
Then I should be redirected to the new klass page
Examples:
|	user	|
|	johan	|
|	aya		|

@allow-rescue
Scenario Outline: Non-admin cannot create a class
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user is logged in as "<user>"
When I go to the new klass page
Then I should be redirected to the events page
Examples:
|	user			|
|	thomas		|
| prince		|
| junko			|
| mika			|