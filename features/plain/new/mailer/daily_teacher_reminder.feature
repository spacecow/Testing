Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", email: "johan@space.com"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "ja", name: "Aya Komatsu", email: "aya@space.com"

@other_days_format
Scenario: Check other day's format of mail of Daily Teacher Reminder for today
Given a klass exists with date: "2010-05-19"
	And a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 33
When the system sends out the daily teacher reminder to concerned teachers at "2010-05-19"
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "Reminder 5/19"
Then I should see the daily teacher reminder mail in english in the email body

@todays_format
Scenario: Check todays format of mail of Daily Teacher Reminder for today
Given a klass exists with todays date
	And a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 33
When the system sends out the daily teacher reminder to concerned teachers
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "Reminder #today"
Then I should see the daily teacher reminder mail in english in the email body

@test_format
Scenario Outline: Check test format of mail of Daily Teacher Reminder for today
Given a klass exists with todays date
	And a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 33
When the system sends out the daily teacher reminder to concerned teachers as <title> test
Then "<address>" should receive 1 email
When "<address>" opens the email with subject "Reminder #today"
Then I should see the daily teacher reminder mail in english in the email body addressed to user "johan"
Examples:
|	title		|	address									|
|	yoyaku	|	Yoyaku@GAKUWARINET.com	|
|	johan		|	jsveholm@gmail.com			|

@not_current_confirmed_untaught
Scenario Outline: Teachings that are neither current, confirmed nor untaught are not affected
Given a klass exists with date: "2010-04-04"
	And a teaching exists with klass: that klass, teacher: user "aya", current: <current>, status_mask: <status>
When the system sends out the daily teacher reminder to concerned teachers at "2010-04-04"
Then "aya@space.com" should receive 0 email
Examples:
|	current	|	status	|
|	false		|	33			|
|	false		|	2				|
|	false		|	4				|
|	false		|	9				|
|	false		|	17			|
|	true		|	2				|
|	true		|	4				|
|	true		|	9				|
|	true		|	17			|

@current_confirmed_untaught
Scenario: Teachings should be current, confirmed and untaught
Given a klass exists with date: "2010-04-04"
	And a teaching exists with klass: that klass, teacher: user "aya", current: true, status_mask: 33
When the system sends out the daily teacher reminder to concerned teachers at "2010-04-04"
Then "aya@space.com" should receive 1 email

Scenario: A teacher should only be informed about todays classes
Given a klass: "class04" exists with date: "2010-04-04"
	And a klass: "class05" exists with date: "2010-04-05"
	And a klass: "class06" exists with date: "2010-04-06"
	And a teaching exists with klass: klass "class04", teacher: user "aya", status_mask: 33
	And a teaching exists with klass: klass "class05", teacher: user "aya", status_mask: 33
	And a teaching exists with klass: klass "class06", teacher: user "aya", status_mask: 33
When the system sends out the daily teacher reminder to concerned teachers at "2010-04-05"
Then "aya@space.com" should receive 1 email
When "aya@space.com" opens the email with subject "本日のスケジュール 4/5"
Then I should not see "4/4(日)" in the email body
	And I should see "4/5(月)" in the email body
	And I should not see "4/6(火)" in the email body

@single
Scenario: Send to a single teacher
Given a klass: "class05-1" exists with date: "2010-04-05"
	And a klass: "class05-2" exists with date: "2010-04-05"
	And a teaching exists with klass: klass "class05-1", teacher: user "johan", status_mask: 33
	And a teaching exists with klass: klass "class05-2", teacher: user "aya", status_mask: 33
When the system sends out the daily teacher reminder to user "johan" at "2010-04-05"
Then "johan@space.com" should receive 1 email
	And "aya@space.com" should receive no email

Scenario: Concerned teachers should get an email each
Given a course: "ruby1" exists with name: "Ruby I"
	And a course: "ruby2" exists with name: "Ruby II"
	And a klass: "johan" exists with date: "2010-04-05", course: course "ruby1", start_time: "12:00", end_time: "13:00"
	And a klass: "aya" exists with date: "2010-04-05", course: course "ruby2", start_time: "14:00", end_time: "15:00"
	And a teaching exists with klass: klass "johan", teacher: user "johan", status_mask: 33
	And a teaching exists with klass: klass "aya", teacher: user "aya", status_mask: 33
When the system sends out the daily teacher reminder to concerned teachers at "2010-04-05"
Then "johan@space.com" should receive 1 email
	And "aya@space.com" should receive 1 email