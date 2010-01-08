@list
Background:
Given a setting exist with name: "main"
	And a user exist with username: "johan", role: "admin", language: "en"
	And a user exist with username: "thomas", role: "observer", language: "en"

Scenario Outline: List a template class
Given a user is logged in as "<user>"
	And a course: "ruby" exists with name: "Ruby I"
	And a classroom: "room1" exists with name: "1"
	And a user: "prince" exists with name: "Prince Philip"
	And a template class exists with teacher: user "prince", course: course "ruby", classroom: classroom "room1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
When I go to the show page of that template class
Then I should see "Template Class" within "legend"
	And I should see "TitleA funny title"
	And I should see "CourseRuby I"
	And I should see "TeacherPrince Philip"
	And I should see "Classroom1"
	And I should see "Capacity8"
	And I should see "DayMonday"
	And I should see "Start time18:50"
	And I should see "End time20:50"
	And I should see "Mail Sending0"
	And I should see "Inactivefalse"
	And I should see "DescriptionA funny description"
Examples:
|	user		|
|	johan		|
|	thomas	|

Scenario Outline: Links
Given a user is logged in as "<user>"
	And a course: "ruby" exists with name: "Ruby I"
	And a classroom: "room1" exists with name: "1"
	And a user: "prince" exists with name: "Prince Philip"
	And a template class exists with teacher: user "prince", course: course "ruby", classroom: classroom "room1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
When I go to the show page of that template class
	And I follow "Ruby I"
Then I should be redirected to the show page of that course
When I go to the show page of that template class
	And I follow "Prince Philip"
Then I should be redirected to the show page of that user
When I go to the show page of that template class
	And I follow "1"
Then I should be redirected to the show page of that classroom
When I go to the show page of that template class
	And I follow "Edit" within "div.links"
Then I should be redirected to the edit page of that template class
When I go to the show page of that template class
	And I follow "List"
Then I should be redirected to the template classes page