Background:
Given a course: "ruby" exists with name: "Ruby I"	
	And a klass exists with date: "2010-03-11", course: course "ruby"
	And a user: "junko" exist with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii", email: "junko@space.com"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", email: "johan@space.com", name: "Johan Sveholm", cost: "1500"

@format
Scenario: Send information about classes that can be reserved to students
Given a courses_student join model exists with course: "Ruby I", student: "junko"
When the system sends out information about reservable classes to concerned students
Then "junko@space.com" should receive 1 email
When "junko@space.com" opens the email with subject "Class reservations"
Then I should see the reservable classes information mail in english in the email body

@test_format
Scenario Outline: Send information about classes that can be reserved to students as test
Given a courses_student join model exists with course: "Ruby I", student: "junko"
When the system sends out information about reservable classes to concerned students as <title> test
Then "<address>" should receive 1 email
When "<address>" opens the email with subject "Class reservations"
Then I should see the reservable classes information mail in english in the email body addressed to user "junko"
Examples:
|	title		|	address									|
|	yoyaku	|	Yoyaku@GAKUWARINET.com	|
|	johan		|	jsveholm@gmail.com			|

Scenario: Send information only to students that have classes they can reserve
Given a course: "rails" exists with name: "Rails II"
	And a courses_student join model exists with course: "Rails II", student: "junko"
When the system sends out information about reservable classes to concerned students
Then "junko@space.com" should receive 0 email