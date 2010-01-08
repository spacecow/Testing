Background:
Given a setting exist with name: "main"
	And a user exist with username: "johan", role: "admin", language: "en"
	And a course: "ruby" exists with name: "Ruby"
	And a classroom: "1" exists with name: "1"
	And a template class exists with course: course "ruby", classroom: classroom "1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"

#@index
#Scenario: List Template Classes
#Given a user is logged in as "johan"
#When I go to the template classes page
#Then I should see "Ruby" table
#|	Ruby Course					|
#|	Lesson			|	Time	|	Unit	|