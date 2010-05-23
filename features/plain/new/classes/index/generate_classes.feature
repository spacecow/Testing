Background:
Given a setting exist with name: "main"
	And a user: "johan" exists with username: "johan", role: "god, teacher", language: "en"
	And a user exists with username: "regular", role: "student, registrant", language: "en"
	And a course exists
	And a classroom exists

Scenario: When choosing a date that does not have any classes, they should be generated if the user is admin
Given a user is logged in as "johan"
	And a template class exists with course: that course, classroom: that classroom, start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: "8", mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "sun"
When I browse to the klasses page of "March 28, 2010"
Then 1 klasses should exist with course: that course, classroom: that classroom, start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: "8", mail_sending: 0, cancel: false, description: "A funny description", note: "A funny note", date: "2010-03-27 15"
	And 0 teachings should exist
	
Scenario: If the template class has a default teacher, he should also turn up in the class
Given a user is logged in as "johan"
	And a template class exists with teacher: user "johan"
When I browse to the klasses page of "March 28, 2010"
Then 1 klasses should exist
	And 1 teachings should exist
	
Scenario Outline: If a non-admin browse to an empty class page, nothing happends
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user is logged in as "<user>"
	And a template class exists with course: that course, classroom: that classroom, start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: "8", mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "sun"
When I browse to the klasses page of "March 28, 2010"
Then 0 klasses should exist
	And 0 teachings should exist
Examples:
|	user			|
|	thomas		|
| prince		|
| junko			|