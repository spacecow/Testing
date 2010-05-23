Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	
Scenario Outline: Only authorized users can create a template class
	And a user is logged in as "<user>"
When I go to the new template class page
Then I should see links "List Template Classes" at the bottom of the page
Examples:
|	user	|
|	johan	|
|	aya		|

@new
Scenario: Create a new template class
Given a course: "ruby" exists with name: "Ruby I", capacity: "8"
	And a course exists with name: "Rails II", capacity: "6"
	And a user is logged in as "aya"
When I go to the new template class page
Then the "Capacity" field should be empty
When I fill in "Title" with "A funny title"
	And I select "Ruby I (8)" from "Course"
	And I select "Monday" from "Day"
	And I fill in "Description" with "A funny description"
	And I fill in "Note" with "A funny note"
	And I press "Create"
Then I should be redirected to the error template classes page
	And "Ruby I (8)" should be selected in the "Course" box
	And "Monday" should be selected in the "Day" box
When I fill in "Start time" with "18:50"
	And I fill in "End time" with "20:50"
	And I fill in "Capacity" with "8"
	And I press "Create"
Then I should be redirected to the template classes page
	And I should see "Successfully created template class" as notice flash message
	And "Monday" should be selected as day in the select menu
	And a template class should exist with course: course "ruby", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
	And I should have 1 template_classes

@allow-rescue
Scenario Outline: Not everyone can create a template class
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"	
	And a user is logged in as "<user>"
When I go to the new template class page
Then I should be redirected to the events page
Examples:
|	user			|
|	thomas		|
| prince		|
| junko			|
| mika			|
|	reiko			|

Scenario: Links from new page
Given a user is logged in as "johan"
When I go to the new template class page
Then I should see links "List Template Classes" at the bottom of the page
When I follow "List Template Classes" at the bottom of the page
Then I should be redirected to the template classes page
