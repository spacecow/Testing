Background:
Given a setting exist with name: "main"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "junko" exist with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a course: "ruby" exists with name: "Ruby I", level_en: "beg.", level_ja: "初級"
	And a courses_student join model exists with course: "Ruby I", student: "junko"
	And a klass: "19" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "18" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"

@reserve
Scenario: Reserve a class
Given a klass: "15" exists with date: "2010-03-15", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a user is logged in as "aya"
When I go to the reserve page for user: "junko" on "2010-03-06"
	And I check "3/15(Monday) - Ruby I - 12:00~13:00"
	And I press "Reserve"
Then I should automatically browse to the klasses page of "March 15, 2010"
	And I should see "Successfully reserved class(es)." as notice flash message
	And 1 attendances should exist with student: user "junko", klass: klass "15"
	And 1 attendances should exist
	#And a mail should exist with subject: "Reservation", message: "You have reserved a class!"
	#And 1 mails should exist
	#And a recipient should exist with user: user "junko", mail: that mail
	#And 1 recipients should exist
	
@reserve
Scenario: Students cannot reserve a class if the reserve-date is modified
Given a klass exists with todays date
	And a user is logged in as "junko"
When I go to the reserve page for user: "junko"
	Then show me the page
	And I reserve that klass
	
@response
Scenario Outline: When a reservation is made an email response is sent to the staff in the user's language
Given a user: "reiko" exist with username: "reiko", role: "registrant, student", language: "ja", name: "Reiko Arikawa"
	And a courses_student join model exists with course: "Ruby I", student: "reiko"
	And a user is logged in as "aya"
When I go to the reserve page for user: "<user>" on "2010-03-06"
	And I check "3/18(Thursday) - Ruby I - 12:00~13:00"
	And I press "Reserve"
Then "jsveholm@gmail.com" should receive 1 email
When "jsveholm@gmail.com" opens the email with subject "<subject>"
Then I should see "<name>" in the email body
	And I should see "<text>" in the email body	
Examples:
|	user	|	name					|	subject									|	text															|
|	junko	|	Junko Sumii		|	Reservations 3/15～3/20	|	3/18(thu) 12:00～13:00(Ruby beg.)	|
|	reiko	|	Reiko Arikawa	|	予約 3/15～3/20						|	3/18(木) 12:00～13:00(Ruby初級)				|

Scenario: A user should be redirected to his MyPage
Given a user is logged in as "junko"
When I go to the reserve page for user: "junko" on "2010-03-06"
	And I press "Reserve"
Then I should be redirected to path "/mypage"

@reserved_history_reserve
Scenario: Classes in Reserved and History should not cease to exist if another reservation is made
Given a klass: "15" exists with date: "2010-02-15", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And an attendance exists with student: user "junko", klass: klass "18"
	And an attendance exists with student: user "junko", klass: klass "15"
	And a user is logged in as "aya"
When I go to the reserve page for user: "junko" on "2010-03-06"
	And I check "3/19(Friday) - Ruby I - 12:00~13:00"
	And I press "Reserve"
Then 1 attendances should exist with student: user "junko", klass: klass "18"
	And 1 attendances should exist with student: user "junko", klass: klass "19"
	And 1 attendances should exist with student: user "junko", klass: klass "15"
	And 3 attendances should exist

@hidden_history_reserve
Scenario: Reserve a class with already reserved classes not showing up in the history
Given an attendance exists with student: user "junko", klass: klass "18"
	And a klass: "25" exists with date: "2010-03-25", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a user is logged in as "aya"
When I go to the reserve page for user: "junko" on "2010-3-13"
	And I check "3/25(Thursday) - Ruby I - 12:00~13:00"
	And I press "Reserve"
Then 1 attendances should exist with student: user "junko", klass: klass "25"
	And 1 attendances should exist with student: user "junko", klass: klass "18"
	And 2 attendances should exist
	
@pending
Scenario: A student should not be able to reserve two classes that overlap in time

@pending
Scenario: After reservation, a mail should go to yoyaku@gakuwarinet.com for confirmation, its going to jsveholm@gmail.com now