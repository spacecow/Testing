Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "prince" exist with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"

Scenario: Make cost inherit from courses_teachers (NOT IMPLEMENTED)
Given not implemented

Scenario: Check that already class history does not get erased when a new class is confirmed (NOT IMPLEMENTED)
Given not implemented

Scenario: Links on confirmation page (NOT IMPLEMENTED)
Given not implemented

@view_confirmable
Scenario: View of classes that can be confirmed
Given a klass: "klass18" exists with date: "2010-03-18"
	And a klass: "klass19" exists with date: "2010-03-19"
	And a klass: "klass20" exists with date: "2010-03-20"
	And a teaching exists with klass: klass "klass18", teacher: user "johan"
	And a teaching exists with klass: klass "klass20", teacher: user "aya"
Given a user is logged in as "johan"
When I go to the confirm page for user: "johan" on "2010-03-06"
Then I should see "Confirm" as title
	And I should see "Classes to Confirm" within "div.confirmable"
	And I should see "3/18(Thursday)" within the confirmable section
	And I should not see "3/19(Friday)" within the confirmable section
	And I should not see "3/20(Saturday)" within the confirmable section
	And the page should have no "confirmed" section
	And the page should have no "taught" section

@view_confirmed
Scenario: View of confirmed classes
Given a klass: "klass18" exists with date: "2010-03-18"
	And a klass: "klass19" exists with date: "2010-03-19"
	And a klass: "klass20" exists with date: "2010-03-20"
	And a teaching exists with klass: klass "klass18", teacher: user "johan", status_mask: 0
	And a teaching exists with klass: klass "klass19", teacher: user "johan", status_mask: 1
	And a teaching exists with klass: klass "klass20", teacher: user "aya", status_mask: 1
Given a user is logged in as "johan"
When I go to the confirm page for user: "johan" on "2010-03-06"
Then I should see "Classes to Confirm" within "div.confirmable"
	And I should see "3/18(Thursday)" within the confirmable section
	And I should not see "3/19(Friday)" within the confirmable section
	And I should not see "3/20(Saturday)" within the confirmable section
	And I should see "Already Confirmed Classes" within "div.confirmed"
	And I should see "3/19(Friday)" within "div.confirmed"
	And I should not see "3/20(Saturday)" within "div.confirmed"
	And the page should have no "taught" section

@view_history
Scenario: View of classes taught
Given a klass: "klass18" exists with date: "2010-03-18"
	And a klass: "klass19" exists with date: "2010-03-19"
	And a klass: "klass20" exists with date: "2010-03-20"
	And a teaching exists with klass: klass "klass18", teacher: user "johan", status_mask: 0
	And a teaching exists with klass: klass "klass19", teacher: user "johan", status_mask: 1
	And a teaching exists with klass: klass "klass20", teacher: user "aya", status_mask: 1
Given a user is logged in as "johan"	
When I go to the confirm page for user: "johan" on "2010-03-26"
	Then the page should have no "confirmable" section
	And the page should have no "confirmed" section
	And I should see "Teaching History" within "div.taught"
	And I should see "3/19(Friday)" within "div.taught"
	And I should see "3/20(Saturday)"
	And I should see "3/18(Thursday)"

Scenario: Only show classes that have been confirmed taught in the history? (NOT IMPLEMENTED)
Given not implemented

@view-late
Scenario: Confirmations can only be made before the class starts
Given a course: "ruby" exists with name: "Ruby I"
	And a klass: "klass18" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a teaching exists with klass: klass "klass18", teacher: user "johan"
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
Then I should see "3/18(Thursday) - Ruby I - 11:00~12:00, 3/18(Thursday) - Ruby I - 12:00~13:00, 3/19(Friday) - Ruby I - 09:00~13:00, 3/19(Friday) - Ruby I - 12:00~13:00, 3/20(Saturday) - Ruby I - 09:00~13:00, 3/20(Saturday) - Ruby I - 17:00~18:00" within the confirmable section

@confirm
Scenario: Confirm a class
Given a course: "ruby" exists with name: "Ruby I"
	And a klass: "klass19" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass18" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a teaching exists with klass: klass "klass19", teacher: user "prince"
	And a teaching exists with klass: klass "klass18", teacher: user "prince"
	And a user is logged in as "prince"
When I go to the confirm page for user: "prince" on "2010-03-06"
	And I confirm klass "klass18" for user "prince" from "2010-03-06"
	And I press "Confirm"
Then I should be redirected to path "/mypage"
	And I should see "Successfully confirmed class(es)." as notice flash message
	And a teaching should exist with klass: klass "klass19", teacher: user "prince", status_mask: 0
	And a teaching should exist with klass: klass "klass18", teacher: user "prince", status_mask: 1
	And 2 teachings should exist
	#And a mail should exist with subject: "Reservation", message: "You have reserved a class!"
	#And 1 mails should exist
	#And a recipient should exist with user: user "johan", mail: that mail
	#And 1 recipients should exist
