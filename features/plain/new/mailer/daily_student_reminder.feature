Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", email: "johan@space.com"
	And a user: "junko" exist with username: "junko", role: "student, registrant", language: "en", name: "Junko Sumii", email: "junko@space.com"

@format @other_day
Scenario: Check other day's format of mail of Daily Student Reminder
Given a course exists with name: "Ruby I", level_en: "beg."
	And a klass exists with date: "2010-05-19", course: that course
	And an attendance exists with klass: that klass, student: user "junko"
	And a courses_student join model exists with course: "Ruby I", student: "junko"
When the system sends out the daily student reminder to concerned students at "2010-05-19"
Then "junko@space.com" should receive 1 email
When "junko@space.com" opens the email with subject "Reminder 5/19"
Then I should see the daily student reminder mail in english in the email body
	And I should see "5/19(wed) 12:00～15:00(beg.)" in the email body

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

@format @today @automagic_johan
Scenario: Check format of mail of Daily Student Reminder for today from Automagic Johan
Given a klass exists with todays date
	And a user: "reiko" exist with username: "reiko", role: "student, registrant", language: "ja", name: "Reiko Arikawa", email: "reiko@space.com"
	And an attendance exists with klass: that klass, student: user "reiko"
When the system sends out the daily student reminder to concerned students from "Automagic Johan"
Then "reiko@space.com" should receive 1 email
When "reiko@space.com" opens the email with subject "本日のスケジュール #today"
Then I should see the daily student reminder mail in japanese in the email body from "Automagic Johan"

@test @format @today @automagic_johan
Scenario Outline: Check test format of Daily Student Reminder for today from Automagic Johan
Given a klass exists with todays date
	And an attendance exists with klass: that klass, student: user "junko"
When the system sends out the daily student reminder to concerned students as <title> test from "Automagic Johan"
Then "<address>" should receive 1 email
When "<address>" opens the email with subject "Reminder #today"
Then I should see the daily student reminder mail in english in the email body addressed to user "junko" from "Automagic Johan"
Examples:
|	title		|	address									|
|	yoyaku	|	Yoyaku@GAKUWARINET.com	|
|	johan		|	jsveholm@gmail.com			|

@today @cancel
Scenario: Students should not be informed about classes that they have canceled
Given a klass exists with todays date
	And an attendance exists with klass: that klass, student: user "junko", cancel: true
When the system sends out the daily student reminder to concerned students
Then "junko@space.com" should receive 0 email