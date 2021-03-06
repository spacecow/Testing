Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"

Scenario Outline: List a template class
Given a course: "ruby" exists with name: "Ruby I"
	And a classroom: "room1" exists with name: "1"
	And a template class exists with teacher: user "aya", course: course "ruby", classroom: classroom "room1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
	And a user is logged in as "johan"
When I go to the show page of that template class
Then I should see "Template Class" within "legend"
	And I should see "TitleA funny title"
	And I should see "CourseRuby I"
	And I should see "TeacherAya Komatsu"
	And I should see "Classroom1"
	And I should see "Capacity8"
	And I should see "DayMonday"
	And I should see "Start time18:50"
	And I should see "End time20:50"
	And I should see "Mail Sending0"
	And I should see "Inactivefalse"
	And I should see "DescriptionA funny description"
	And I should see links "Edit, Del, List Template Classes" at the bottom of the page

Scenario Outline: Only authorized users can see the show page of a template class
Given a template class exists
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user is logged in as "<user>"
When I go to the show page of that template class
Then I should see links "<options>" at the bottom of the page
Examples:
|	user		|	options											|
|	johan		|	Edit, Del, List Template Classes	|
|	aya			|	Edit, Del, List Template Classes	|
|	thomas	|	List Template Classes				|

Scenario: Links from a show page of a template class
Given a course: "ruby" exists with name: "Ruby I"
	And a classroom: "room1" exists with name: "1"
	And a template class exists with teacher: user "johan", course: course "ruby", classroom: classroom "room1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
	And a user is logged in as "aya"
When I go to the show page of that template class
	And I follow "Ruby I"
Then I should be redirected to the show page of that course
When I go to the show page of that template class
	And I follow "Johan Sveholm"
Then I should be redirected to the show page of user: "johan"
When I go to the show page of that template class
	And I follow "1"
Then I should be redirected to the show page of that classroom
When I go to the show page of that template class
	And I follow "Edit" at the bottom of the page
Then I should be redirected to the edit page of that template class
When I go to the show page of that template class
	And I follow "List Template Classes" at the bottom of the page
Then I should be redirected to the template classes page
	And 1 template_classes should exist
When I go to the show page of that template class
	And I follow "Del" at the bottom of the page
Then I should be redirected to the template classes page
	And 0 template_classes should exist

@allow-rescue
Scenario Outline: Some users cannot reach this page
Given a template class exists
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"	
	And a user is logged in as "<user>"
When I go to the show page of that template class
Then I should be redirected to the events page
Examples:
|	user			|
| prince		|
| junko			|
| mika			|
|	reiko			|