Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Junko Sumii"

Scenario Outline: Only authorized users can delete a template class
Given a template class exists
	And a user is logged in as "<user>"
When I go to the show page of that template class
	And I follow "Del" at the bottom of the page
Then 0 template_classes should exist
Examples:
|	user	|
|	johan	|
|	aya		|

Scenario: Delete a template class and no associations should be deleted (later on students?)
Given a course: "ruby" exists with name: "Ruby I"
	And a classroom: "room1" exists with name: "1"
	And a template class exists with course: course "ruby", classroom: classroom "room1", teacher: user "johan"
	And a user is logged in as "aya"
Then 1 template_classes should exist
	And 1 courses should exist
	And 1 classrooms should exist
	And 2 users should exist
	And 2 teachers should exist
When I go to the show page of the template class
	And I follow "Del" within "div#links"
Then I should be redirected to the template classes page
	And I should see "Successfully deleted template class" within "div#notice"
	And 0 template_classes should exist
	And 1 courses should exist
	And 1 classrooms should exist
	And 2 users should exist
	And 2 teachers should exist	
