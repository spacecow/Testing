Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", email: "johan@space.com"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "ja", name: "Aya Komatsu", email: "aya@space.com"
	
@check
Scenario: Check format of mail of weekly teacher schedule in japanese
Given a klass exists with date: "2010-04-06"
	And a teaching exists with klass: that klass, teacher: user "aya"
When the system sends out the weekly schedule to concerned teachers at "2010-04-04"
Then "aya@space.com" should receive 1 email
When "aya@space.com" opens the email with subject "来週のシフトについて"
Then I should see the weekly teacher schedule mail in japanese in the email body

@date
Scenario Outline: Next week's schedule
Given a klass exists with date: "2010-05-31"
	And a teaching exists with klass: that klass, teacher: user "aya"
When the system sends out the weekly schedule to concerned teachers at "<date>"
Then "aya@space.com" should receive 1 email
Examples:
|	date				|
|	2010-05-24	|
|	2010-05-25	|
|	2010-05-26	|
|	2010-05-27	|
|	2010-05-28	|
|	2010-05-29	|
|	2010-05-30	|

@not_current
Scenario Outline: Teachings that are not current are not affected
Given a klass exists with date: "2010-04-06"
	And a teaching exists with klass: that klass, teacher: user "aya", current: <current>, status_mask: <status>
When the system sends out the weekly schedule to concerned teachers at "2010-04-04"
Then "aya@space.com" should receive 0 email
Examples:
|	current	|	status	|
|	false		|	33			|
|	false		|	2				|
|	false		|	4				|
|	false		|	9				|
|	false		|	17			|
|	true		|	2				|

@current
Scenario Outline: Teachings should be current
Given a klass exists with date: "2010-04-06"
	And a teaching exists with klass: that klass, teacher: user "aya", current: <current>, status_mask: <status>
When the system sends out the weekly schedule to concerned teachers at "2010-04-04"
Then "aya@space.com" should receive 1 email
Examples:
|	current	|	status	|
|	true		|	33			|
|	true		|	4				|
|	true		|	9				|
|	true		|	17			|
	
@check
Scenario: Check format of mail of weekly teacher schedule in english
Given a klass exists with date: "2010-04-06"
	And a teaching exists with klass: that klass, teacher: user "johan"
When the system sends out the weekly schedule to concerned teachers at "2010-04-04"
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "Schedule for next week"
Then I should see "Hello!" in the email body
	And I should see "this is Hitomi." in the email body
	And I should see "please check next week's schedule and" in the email body
	And I should see "when you get this mail, please reply to me!" in the email body
	And I should see "see you~!" in the email body

Scenario: A teacher should only be informed about classes the coming week
Given a klass: "class04" exists with date: "2010-04-04"
	And a klass: "class05" exists with date: "2010-04-05"
	And a klass: "class10" exists with date: "2010-04-10"
	And a klass: "class11" exists with date: "2010-04-11"
	And a klass: "class12" exists with date: "2010-04-12"
	And a teaching exists with klass: klass "class04", teacher: user "johan"
	And a teaching exists with klass: klass "class05", teacher: user "johan"
	And a teaching exists with klass: klass "class10", teacher: user "johan"
	And a teaching exists with klass: klass "class11", teacher: user "johan"
	And a teaching exists with klass: klass "class12", teacher: user "johan"
When the system sends out the weekly schedule to concerned teachers at "2010-04-04"
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "Schedule for next week"
Then I should not see "4/4(sun)" in the email body
	And I should see "4/5(mon)" in the email body
	And I should see "4/10(sat)" in the email body
	And I should see "4/11(sun)" in the email body
	And I should not see "4/12(mon)" in the email body

@single
Scenario: Send to a single teacher
Given a klass: "class05" exists with date: "2010-04-05"
	And a klass: "class10" exists with date: "2010-04-10"
	And a teaching exists with klass: klass "class05", teacher: user "johan"
	And a teaching exists with klass: klass "class10", teacher: user "aya"
When the system sends out the weekly schedule to user "johan" at "2010-04-04"
Then "johan@space.com" should receive 1 email
	And "aya@space.com" should receive no email

Scenario: Concerned teachers should get an email each
Given a course: "ruby1" exists with name: "Ruby I"
	And a course: "ruby2" exists with name: "Ruby II"
	And a klass: "class05" exists with date: "2010-04-05", course: course "ruby1", start_time: "12:00", end_time: "13:00"
	And a klass: "class10" exists with date: "2010-04-10", course: course "ruby2", start_time: "14:00", end_time: "15:00"
	And a teaching exists with klass: klass "class05", teacher: user "johan"
	And a teaching exists with klass: klass "class10", teacher: user "aya"
When the system sends out the weekly schedule to concerned teachers at "2010-04-04"
Then "johan@space.com" should receive 1 email
	And "aya@space.com" should receive 1 email
	
@format
Scenario: Check format of mail of Daily Teacher Reminder for today
Given a klass exists a week from now
	And a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 33
When the system sends out the weekly schedule to concerned teachers
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "Schedule for next week"
Then I should see the weekly teacher schedule mail in english in the email body

@test_format
Scenario Outline: Check test format of mail of Daily Teacher Reminder for today
Given a klass exists a week from now
	And a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 33
When the system sends out the weekly schedule to concerned teachers as <title> test
Then "<address>" should receive 1 email
When "<address>" opens the email with subject "Schedule for next week"
Then I should see the weekly teacher schedule mail in english in the email body addressed to user "johan"
Examples:
|	title		|	address									|
|	yoyaku	|	Yoyaku@GAKUWARINET.com	|
|	johan		|	jsveholm@gmail.com			|






















