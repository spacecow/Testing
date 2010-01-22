@new
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Junko Sumii"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant, student", language: "ja", name: "Akira Kurosawa"	
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	
Scenario Outline: Create a new template class
Given a course: "ruby" exists with name: "Ruby I"
	And a course exists with name: "Rails II"
	And a user is logged in as "<user>"
When I go to the new template class page
	And I fill in "Title" with "A funny title"
	And I select "Ruby I" from "Course"
	And I select "Monday" from "Day"
	And I fill in "Description" with "A funny description"
	And I fill in "Note" with "A funny note"
	And I press "Create"
Then I should be redirected to the error template classes page
	And "Ruby I" should be selected in the "Course" box
	And "Monday" should be selected in the "Day" box
When I fill in "Start time" with "18:50"
	And I fill in "End time" with "20:50"
	And I press "Create"
Then I should be redirected to the template classes page
	And I should see "Successfully created template class" within "#notice"
	And a template class should exist with course: course "ruby", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
	And I should have 1 template classes
Examples:
|	user	|
|	johan	|
|	aya		|

Scenario Outline: Not everyone can create a template class
Given a user is logged in as "<user>"
When I go to the new template class page
Then I should be redirected to the events page
Examples:
|	user			|
|	thomas		|
| prince		|
| junko			|
| mika			|

Scenario Outline: Links from new page
Given a user is logged in as "<user>"
When I go to the new template class page
Then I should see options "List Template Classes" within "div#links"
When I follow "List Template Classes" within "div#links"
Then I should be redirected to the template classes page
Examples:
|	user	|
|	johan	|
|	aya		|