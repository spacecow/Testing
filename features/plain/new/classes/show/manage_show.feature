Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"

Scenario: List a class
Given a course: "ruby" exists with name: "Ruby I"
	And a classroom: "room1" exists with name: "1"
	And a klass exists with date: "2012-3-28", course: course "ruby", classroom: classroom "room1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, cancel: false, description: "A funny description", note: "A funny note"
	And a teaching exists with teacher: user "aya", klass: that klass
	And a user is logged in as "johan"
When I go to the show page of that klass
Then I should see "Class" within "legend"
	And I should see "TitleA funny title"
	And I should see "CourseRuby I"
	And I should see "TeacherAya Komatsu"
	And I should see "Classroom1"
	And I should see "Capacity8"
	And I should see "Date2012-03-28"
	And I should see "Start time18:50"
	And I should see "End time20:50"
	And I should see "Cancelfalse"
	And I should see "DescriptionA funny description"
	And I should see links "Edit, Del, List Classes" at the bottom of the page

Scenario: Links from class' show page
Given a course: "ruby" exists with name: "Ruby I"
	And a classroom: "room1" exists with name: "1"
	And a klass exists with date: "2012-3-28", teacher: user "aya", course: course "ruby", classroom: classroom "room1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, cancel: false, description: "A funny description", note: "A funny note"
	And a user is logged in as "aya"
When I go to the show page of that klass
	And I follow "Ruby I"
Then I should be redirected to the show page of that course
When I go to the show page of that klass
	And I follow "Aya Komatsu"
Then I should be redirected to the show page of user: "aya"
When I go to the show page of that klass
	And I follow "1"
Then I should be redirected to the show page of that classroom
When I go to the show page of that klass
	And I follow "Edit" at the bottom of the page
Then I should be redirected to the edit page of that klass
When I go to the show page of that klass
	And I follow "List Classes" at the bottom of the page
Then I should be redirected to the klasses page
	And "March 28, 2012" should be selected as date in the select menu	
	And 1 klasses should exist
When I go to the show page of that klass
	And I follow "Del" at the bottom of the page
Then I should be redirected to the klasses page
	And "March 28, 2012" should be selected as date in the select menu	
 	And I should see "Successfully deleted class." as notice flash message
	And 0 klasses should exist

@allow-rescue
Scenario: Registrants cannot reach this page
Given a klass exists
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
Given a user is logged in as "mika"
When I go to the show page of that klass
Then I should be redirected to the events page

Scenario Outline: Visual links for authorized users
Given a klass exists
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user is logged in as "<user>"
When I go to the show page of that klass
Then I should see links "<links>" at the bottom of the page
Examples:
|	user		|	links										|
| johan		|	Edit, Del, List Classes	|
| aya			|	Edit, Del, List Classes	|
| thomas	|	List Classes						|
| prince	|	List Classes						|
| junko		|	List Classes						|