Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"

Scenario Outline: Only admins can send out reminders manually
Given a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user is logged in as "<user>"
When I browse to the teachers page
	And I follow "<link> Mail" within user "thomas"
Then I should be redirected to the mailer page
Examples:
|	user	|	link		|
|	johan	|	Weekly	|
|	aya		|	Daily		|

@allow-rescue
Scenario Outline: Non-admins cannot send out reminders
Given a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"
	And a user is logged in as "<user>"
When I go to the mailer page
Then I should be redirected to the events page
Examples:
|	user		|
|	prince	|
|	thomas	|
|	junko		|
|	mika		|
|	reiko		|

@view
Scenario Outline: Mail view in different languages
Given a user: "aya" exist with username: "aya", role: "admin, teacher", language: "ja", name: "Aya Komatsu"
Given a user is logged in as "<user>"
When I browse to the "Daily Mail" page for user "thomas" of "December 24, 2011"
Then "December 24, 2011" should be selected as date in the select menu
	And "menu_language" should have options "<languages>" in the select menu
	And "<language>" should be selected as language in the select menu
	And "menu_teacher" should have options "Johan Sveholm, Thomas Osburg, Aya Komatsu"
	And "Thomas Osburg" should be selected as teacher in the select menu
	And "menu_type" should have options "<types>"
	And "<type>" should be selected as type in the select menu
Examples:
|	user	|	languages					|	language	|	types																						|	type										|
|	johan	|	Japanese, English	|	English		|	Daily Teacher Reminder, Weekly Teacher Schedule |	Daily Teacher Reminder	|
|	aya		|	日本語, 英語						|	英語				|	毎日思い起こさせる講師メール, 一週間の講師スケジュール										|	毎日思い起こさせる講師メール					|


@different
Scenario Outline: Display daily mail in different languages
Given a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "ja", name: "Prince Philip"
Given a user is logged in as "johan"
	And a course exists with name: "Ruby I"
	And a klass: "1" exists with date: "2011-12-24", course: that course, start_time: "12:00", end_time: "12:50"
	And a klass: "2" exists with date: "2011-12-24", course: that course, start_time: "13:00", end_time: "15:00"
	And a teaching exists with klass: klass "1", teacher: user "thomas", status_mask: 33
	And a teaching exists with klass: klass "2", teacher: user "prince", status_mask: 33
When I browse to the "Daily Mail" page for user "<user>" of "December 24, 2011"
	And I should see the daily teacher reminder mail in <language> within "div#text_message"
	And I should see "12/24(<day>)" within "div#text_message"
Examples:
|	user		|	language	|	day	|
|	thomas	|	English		|	sat	|
|	prince	|	Japanese	|	土		|

Scenario: One can only see remainer mail for days with classes
Given a user is logged in as "johan"
	And a course exists with name: "Ruby I"
	And a klass exists with date: "2011-12-24", course: that course, start_time: "12:00", end_time: "12:50"
	And a teaching exists with klass: that klass, teacher: user "thomas"
When I browse to the "Daily Mail" page for user "thomas" of "December 23, 2011"
Then I should not see "12/24" within "div#text_message"
