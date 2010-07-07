Background:
Given a setting exist with name: "main"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "junko" exist with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "junko"
	And a klass: "19" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "18" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"

@reserve
Scenario: Reserve a class
Given a user is logged in as "aya"
When I go to the reserve page for user: "junko" on "2010-03-06"
	And I check "3/18(Thursday) - Ruby I - 12:00~13:00"
	And I press "Reserve"
Then I should automatically browse to the klasses page of "March 18, 2010"
	And I should see "Successfully reserved class(es)." as notice flash message
	And 1 attendances should exist with student: user "junko", klass: klass "18"
	And 1 attendances should exist
	And "jsveholm@gmail.com" should receive 1 email
	#And a mail should exist with subject: "Reservation", message: "You have reserved a class!"
	#And 1 mails should exist
	#And a recipient should exist with user: user "junko", mail: that mail
	#And 1 recipients should exist

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
Scenario: After reservation, a mail should go to yoyaku@gakuwarinet.com for confirmation