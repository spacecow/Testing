@new
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"

@new_class
Scenario: Create a new class
Given a user is logged in as "johan"
	And a course: "ruby" exists with name: "Ruby I"
	And a course exists with name: "Rails II"
	And a course exists with name: "Fortran I"
When I go to the new klass page
	And I select "Ruby I" from "Course"
	And I select "February 20, 2010" as the date
	And I fill in "Start time" with "13:00"
	And I fill in "End time" with "14:00"
	And I fill in "Capacity" with "8"
	And I fill in "Title" with "Did you know"
	And I fill in "Description" with "ishigani in Japanese"
	And I fill in "Note" with "is stone crab in English"
	And I press "Create"
Then I should be redirected to the klasses page
	And I should see "Successfully created Class."
	And a klass should exist with course: course "ruby", date: "2010-2-20", start_time: "13:00", end_time: "14:00", capacity: 8, title: "Did you know", description: "ishigani in Japanese", note: "is stone crab in English"
	And 1 klasses should exist

@new_view
Scenario: New view
Given a course exists with name: "Ruby I"
	And a course exists with name: "Fortran I"	
	And a course exists with name: "Rails II"
	And a user is logged in as "johan"
When I go to the new klass page
Then I should see "New Class" within "legend"
	And the "Course" field should have options "BLANK, Ruby I, Rails II, Fortran I"
	And "" should be selected in the "Course" field
	And "" should be selected in "klass_date_1i"
	And "" should be selected in "klass_date_2i"
	And "" should be selected in "klass_date_3i"
	And the "Start time" field should be empty
	And I should see "Ex. 17:50" within "li#klass_start_time_string_input"
	And the "End time" field should be empty
	And I should see "Ex. 18:40" within "li#klass_end_time_string_input"
	And the "Cancel" checkbox should not be checked
	And the "Capacity" field should be empty
	And the "Title" field should be empty
	And the "Description" field should contain ""
	And the "Note" field should contain ""
	
Scenario: Links from new page
Given a user is logged in as "johan"
When I go to the new klass page
Then I should see options "List Classes" within "div#links"
When I follow "List Classes" within "div#links"
Then I should be redirected to the klasses page

Scenario Outline: Only users with permission can create classes
	Given a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Junko Sumii"
	And a user is logged in as "<user>"
When I go to the new klass page
Then I should be redirected to the new klass page
Examples:
|	user	|
|	johan	|
|	aya		|

@allow-rescue
Scenario Outline: Not everyone can create a class
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

Scenario: Capacity changed automatically by change of course (AJAX)
Given not implemented