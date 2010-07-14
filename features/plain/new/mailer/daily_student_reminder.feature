Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", email: "johan@space.com"
	And a user: "junko" exist with username: "junko", role: "student, registrant", language: "en", name: "Junko Sumii", email: "junko@space.com"

@format @other_day
Scenario: Check other day's format of mail of Daily Student Reminder
Given a klass exists with date: "2010-05-19"
	And an attendance exists with klass: that klass, student: user "junko"
When the system sends out the daily student reminder to concerned students at "2010-05-19"
Then "junko@space.com" should receive 1 email
When "junko@space.com" opens the email with subject "Reminder 5/19"
Then I should see the daily student reminder mail in english in the email body

@format @today
Scenario: Check todays format of mail of Daily Student Reminder
Given a klass exists with todays date
	And an attendance exists with klass: that klass, student: user "junko"
When the system sends out the daily student reminder to concerned students
Then "junko@space.com" should receive 1 email
When "junko@space.com" opens the email with subject "Reminder #today"
Then I should see the daily student reminder mail in english in the email body

@test @format @today
Scenario Outline: Check test format of mail of Daily Student Reminder for today
Given a klass exists with todays date
	And an attendance exists with klass: that klass, student: user "junko"
When the system sends out the daily student reminder to concerned students as <title> test
Then "<address>" should receive 1 email
When "<address>" opens the email with subject "Reminder #today"
Then I should see the daily student reminder mail in english in the email body addressed to user "junko"
Examples:
|	title		|	address									|
|	yoyaku	|	Yoyaku@GAKUWARINET.com	|
|	johan		|	jsveholm@gmail.com			|

@pending
Scenario: Exceptions for canceled classes etc.