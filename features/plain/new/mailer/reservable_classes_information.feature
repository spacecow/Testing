Background:
Given a course: "ruby" exists with name: "Ruby I"	
	And a user: "junko" exist with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii", email: "junko@space.com"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", email: "johan@space.com", name: "Johan Sveholm", cost: "1500"

@format
Scenario Outline: Send information about classes that can be reserved to students in english and japanese
Given a user: "reiko" exist with username: "reiko", role: "registrant, student", language: "ja", name: "Junko Sumii", email: "reiko@space.com"
	And a klass exists with date: "2010-03-08", course: course "ruby"
	And a courses_student join model exists with course: "Ruby I", student: "<user>"
When the system sends out information about reservable classes to concerned students at "2010-02-27"
Then "<user>@space.com" should receive 1 email
When "<user>@space.com" opens the email with subject "<subject>"
Then I should see "<text>" in the email body
	And I should see a link to the reserve section for user "<user>" in the email body
Examples:
|	user 	|	language	|	subject								|	text																				|
|	junko	|	english		|	Reservations 3/8～3/13	|	Reservations can now be made for 3/8～3/13.	|
|	reiko	|	japanese	|	予約 3/8～3/13						|	Reservations can now be made for 3/8～3/13.	|


@no_class
Scenario Outline: The classes are not in the span for reservation
Given a courses_student join model exists with course: "Ruby I", student: "junko"
	And a klass exists with date: "2010-03-<day>", course: course "ruby"
When the system sends out information about reservable classes to concerned students at "2010-02-27"
Then "junko@space.com" should receive 0 email
Examples:
| day |
| 07	|
| 14	|

@yes_class
Scenario Outline: Classes that are in the span for reservation (mon-sat)
Given a courses_student join model exists with course: "Ruby I", student: "junko"
	And a klass exists with date: "2010-03-<day>", course: course "ruby"
When the system sends out information about reservable classes to concerned students at "2010-02-27"
Then "junko@space.com" should receive 1 email
Examples:
| day |
| 08	|
| 09	|
| 10	|
| 11	|
| 12	|
| 13	|

@test_format
Scenario Outline: Send information about classes that can be reserved to students as test
Given a courses_student join model exists with course: "Ruby I", student: "junko"
	And a klass exists with date: "2010-03-08", course: course "ruby"
When the system sends out information about reservable classes to concerned students at "2010-02-27" as <title> test
Then "<address>" should receive 1 email
When "<address>" opens the email with subject "Reservations 3/8～3/13"
Then I should see the reservable classes information mail in english in the email body addressed to user "junko"
Examples:
|	title		|	address									|
|	yoyaku	|	Yoyaku@GAKUWARINET.com	|
|	johan		|	jsveholm@gmail.com			|

Scenario: Send information only to students that have classes they can reserve
Given a course: "rails" exists with name: "Rails II"
	And a courses_student join model exists with course: "Rails II", student: "junko"
	And a klass exists with date: "2010-03-08", course: course "ruby"	
When the system sends out information about reservable classes to concerned students at "2010-02-27"
Then "junko@space.com" should receive 0 email

@pending
Scenario: Translate Reservable Classes Information & Reservation of Classes mail into japanese