Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "prince" exist with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"

Scenario: Make cost inherit from courses_teachers (NOT IMPLEMENTED)
Given not implemented

Scenario: Confirm another class (NOT IMPLEMENTED)
Given not implemented

Scenario: If there are no classes to confirm, that section should not be visable (NOT IMPLEMENTED)
Given not implemented

Scenario: Links on confirmation page (NOT IMPLEMENTED)
Given not implemented

Scenario: Confirmation View
Given a user is logged in as "johan"
When I go to the confirm page for user: "johan"
Then I should see "Confirm" as title

Scenario: Only classes that have been set up by admin can be confirmed
Given a klass: "klass18" exists with date: "2010-03-18"
	And a klass: "klass19" exists with date: "2010-03-19"
	And a klass: "klass20" exists with date: "2010-03-20"
	And a teaching exists with klass: klass "klass18", teacher: user "johan"
	And a teaching exists with klass: klass "klass20", teacher: user "aya"
Given a user is logged in as "johan"
When I go to the confirm page for user: "johan" on "2010-03-06"
Then I should see "Classes to Confirm" within "div.confirmable"
	And I should see "3/18(Thursday)" within "div.confirmable"
	And I should not see "3/19(Friday)" within "div.confirmable"
	And I should not see "3/20(Saturday)" within "div.confirmable"

@view-late
Scenario: Confirmations can only be made before the class starts
Given a course: "ruby" exists with name: "Ruby I"
	And a klass exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
Given a user is logged in as "johan"
When I go to the confirm page for user: "johan" on "2010-03-26"
Then I should see "Confirm" as title
	And the page should have no "confirmable" section
	And I should see "You have no classes to confirm." within "div.intro"
	
@allow-rescue
Scenario Outline: Regular teachers can only see their own confiration page, but admins have no limit
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "junko" exist with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"
	And a user is logged in as "<user>"
When I go to the confirm page for user: "<user>"
Then I should be redirected to the <own-page>
When I go to the confirm page for user: "junko"
Then I should be redirected to the <other-page>
Examples:
|	user		|	own-page												|	other-page											|
|	thomas	|	confirm page for user: "thomas"	|	events page											|
|	prince	|	confirm page for user: "prince"	|	events page											|
|	junko 	|	events page											|	events page											|
|	mika		|	events page											|	events page											|
|	reiko 	|	events page											|	events page											|
|	johan 	|	confirm page for user: "johan"	|	confirm page for user: "junko"	|
|	aya		 	|	confirm page for user: "aya"		|	confirm page for user: "junko"	|

@order
Scenario: Classes should be displayed in order after day, time interval
Given a course: "ruby" exists with name: "Ruby I"
	And a klass: "klass19-2" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass18-2" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass18-1" exists with date: "2010-03-18", course: course "ruby", start_time: "11:00", end_time: "12:00"
	And a klass: "klass20-1" exists with date: "2010-03-20", course: course "ruby", start_time: "09:00", end_time: "13:00"
	And a klass: "klass20-2" exists with date: "2010-03-20", course: course "ruby", start_time: "17:00", end_time: "18:00"
	And a klass: "klass19-1" exists with date: "2010-03-19", course: course "ruby", start_time: "09:00", end_time: "13:00"
	And a teaching exists with klass: klass "klass19-2", teacher: user "johan"
	And a teaching exists with klass: klass "klass18-2", teacher: user "johan"
	And a teaching exists with klass: klass "klass18-1", teacher: user "johan"
	And a teaching exists with klass: klass "klass20-1", teacher: user "johan"
	And a teaching exists with klass: klass "klass20-2", teacher: user "johan"
	And a teaching exists with klass: klass "klass19-1", teacher: user "johan"	
	And a user is logged in as "johan"
When I go to the confirm page for user: "johan" on "2010-03-06"
Then I should see "3/18(Thursday) - Ruby I - 11:00~12:00 3/18(Thursday) - Ruby I - 12:00~13:00 3/19(Friday) - Ruby I - 09:00~13:00 3/19(Friday) - Ruby I - 12:00~13:00 3/20(Saturday) - Ruby I - 09:00~13:00 3/20(Saturday) - Ruby I - 17:00~18:00" within "div.confirmable"

@confirm
Scenario: Confirm a class
Given a course: "ruby" exists with name: "Ruby I"
	And a klass: "klass19" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass18" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a teaching exists with klass: klass "klass19", teacher: user "prince"
	And a teaching exists with klass: klass "klass18", teacher: user "prince"
	And a user is logged in as "prince"
When I go to the confirm page for user: "prince" on "2010-03-06"
	And the page should have no "confirmed" section
	And the page should have no "taught" section
	And I check "3/18(Thursday) - Ruby I - 12:00~13:00"
	And I press "Confirm"
Then I should be redirected to path "/mypage"
	And I should see "Successfully confirmed class(es)." as notice flash message
	And a teaching should exist with klass: klass "klass19", teacher: user "prince", status: 0
	And a teaching should exist with klass: klass "klass18", teacher: user "prince", status: 0
	And 2 teachings should exist
	#And 1 attendances should exist
	#And a mail should exist with subject: "Reservation", message: "You have reserved a class!"
	#And 1 mails should exist
	#And a recipient should exist with user: user "johan", mail: that mail
	#And 1 recipients should exist
