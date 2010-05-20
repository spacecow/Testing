Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", email: "johan@space.com"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "ja", name: "Aya Komatsu", email: "aya@space.com"
	
Scenario: Daily Staff Reminder at date
Given a klass: "1" exists with date: "2010-04-04"
	And a klass: "2" exists with date: "2010-04-04"
	And a teaching exists with klass: klass "1", teacher: user "aya", current: true, status_mask: 33, cost: "0"
	And a teaching exists with klass: klass "2", teacher: user "johan", current: true, status_mask: 33, cost: "1500"
When the system sends out the daily staff reminder to concerned teachers at "2010-04-04"
Then "aya@space.com" should receive 1 email
	And "johan@space.com" should receive no email

Scenario: Daily Staff Reminder for today
Given a klass exists with todays date
	And a teaching exists with klass: that klass, teacher: user "aya", current: true, status_mask: 33, cost: "0"
When the system sends out the daily staff reminder to concerned teachers
Then "aya@space.com" should receive 1 email

@format
Scenario: Check format of mail of Daily Staff Reminder for today
Given a klass exists with todays date
	And a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 33, cost: "0"
When the system sends out the daily staff reminder to concerned teachers
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "Reminder"
Then I should see the daily teacher reminder mail in english in the email body

@test_format
Scenario Outline: Check test format of mail of Daily Staff Reminder for today
Given a klass exists with todays date
	And a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 33, cost: "0"
When the system sends out the daily staff reminder to concerned teachers as <title> test
Then "<address>" should receive 1 email
When "<address>" opens the email with subject "Reminder"
Then I should see the daily teacher reminder mail in english in the email body addressed to user "johan"
Examples:
|	title		|	address									|
|	yoyaku	|	Yoyaku@GAKUWARINET.com	|
|	johan		|	jsveholm@gmail.com			|

@format_from_automagic_johan
Scenario: Check format of mail of Daily Staff Reminder for today from Automagic Johan
Given a klass exists with todays date
	And a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 33, cost: "0"
When the system sends out the daily staff reminder to concerned teachers from "Automagic Johan"
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "Reminder"
Then I should see the daily teacher reminder mail in english in the email body from "Automagic Johan"

@test_format_from_automagic_johan
Scenario Outline: Check test format of Daily Staff Reminder for today from Automagic Johan
Given a klass exists with todays date
	And a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 33, cost: "0"
When the system sends out the daily staff reminder to concerned teachers as <title> test from "Automagic Johan"
Then "<address>" should receive 1 email
When "<address>" opens the email with subject "Reminder"
Then I should see the daily teacher reminder mail in english in the email body addressed to user "johan" from "Automagic Johan"
Examples:
|	title		|	address									|
|	yoyaku	|	Yoyaku@GAKUWARINET.com	|
|	johan		|	jsveholm@gmail.com			|