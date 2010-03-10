Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "junko" exist with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"

@view
Scenario: View of the reserve page
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "johan"
	And a klass exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a user is logged in as "aya"
When I go to the reserve page for user: "johan" on "2010-03-06"
Then I should see "Reserve" as title
	And I should see "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.reservable"
	And I should see "Reservations can be made from Sat 12am to Tue 5pm." within "div.reservable"

@days
Scenario Outline: Reservations can only be made from Sat to Tue
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "junko"
	And a klass exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a user is logged in as "junko"
When I go to the reserve page for user: "junko" on "2010-03-<day>"
Then I should see "<view>" within "fieldset.form div.intro"
Examples:
|	day	|	view																	|
|	03	|	You can do no reservations today.			|
|	04	|	You can do no reservations today.			|
|	05	|	You can do no reservations today.			|
|	06	|	3/18(Thursday) - Ruby I - 12:00~13:00	|
|	07	|	3/18(Thursday) - Ruby I - 12:00~13:00	|
|	08	|	3/18(Thursday) - Ruby I - 12:00~13:00	|
|	09	|	3/18(Thursday) - Ruby I - 12:00~13:00	|

@2weeks
Scenario Outline: You can only reserve for 2 weeks ahead
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "junko"
	And a klass exists with date: "2010-03-11", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2010-03-25", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a user is logged in as "junko"
When I go to the reserve page for user: "junko" on "<date>"
Then I <week1> see "3/11(Thursday) - Ruby I - 12:00~13:00" within "div.reservable"
	And I <week2> see "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.reservable"
	And I <week3> see "3/25(Thursday) - Ruby I - 12:00~13:00" within "div.reservable"
Examples:
|	date				|	week1				|	week2				|	week3				|
|	2010-02-27	|	should			|	should not	|	should not	|
|	2010-03-06	|	should not	|	should			|	should not	|
|	2010-03-13	|	should not	|	should not	|	should			|

@double
Scenario: Same class should not be displayed double
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "johan"
	And a klass exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a user is logged in as "aya"
When I go to the reserve page for user: "johan" on "2010-03-06"
Then I should see "3/18(Thursday) - Ruby I - 12:00~13:00"
	And I should not see "3/18(Thursday) - Ruby I - 12:00~13:00 3/18(Thursday) - Ruby I - 12:00~13:00"

@already_reserved
Scenario Outline: If a class exists doubled, the one in use should be displayed
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "johan"
	And a klass: "klass16-1" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass16-2" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And an attendance exists with student: user "johan", klass: klass "<klass>"
	And a user is logged in as "aya"
When I go to the reserve page for user: "johan" on "2010-03-06"
Then I should see "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.reserved"
	And the page should have no "reservable" section
Examples:
|	klass			|
|	klass16-1	|
|	klass16-2	|

@multiple
Scenario: Classes should be displayed in order after day, time interval and only courses belonging to the user
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "johan"
	And a course: "rails" exists with name: "Rails II"
	And a klass exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2010-03-18", course: course "rails", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2010-03-18", course: course "ruby", start_time: "11:00", end_time: "12:00"
	And a klass exists with date: "2010-03-20", course: course "ruby", start_time: "09:00", end_time: "13:00"
	And a klass exists with date: "2010-03-20", course: course "ruby", start_time: "17:00", end_time: "18:00"
	And a klass exists with date: "2010-03-19", course: course "ruby", start_time: "09:00", end_time: "13:00"
	And a user is logged in as "aya"
When I go to the reserve page for user: "johan" on "2010-03-06"
Then I should see "3/18(Thursday) - Ruby I - 11:00~12:00 3/19(Friday) - Ruby I - 09:00~13:00 3/19(Friday) - Ruby I - 12:00~13:00 3/20(Saturday) - Ruby I - 09:00~13:00 3/20(Saturday) - Ruby I - 17:00~18:00"

@reserve
Scenario: Reserve a class
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "johan"
	And a klass exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass16" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a user is logged in as "aya"
When I go to the reserve page for user: "johan" on "2010-03-06"
Then I should see "Classes to Reserve" within "div.reservable"
	And I should see "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.reservable"
	And I should see "3/19(Friday) - Ruby I - 12:00~13:00" within "div.reservable"
	And the page should have no "reserved" section
	And the page should have no "history" section
	And I check "3/18(Thursday) - Ruby I - 12:00~13:00"
	And I press "Reserve"
Then I should be redirected to path "/mypage"
	And I should see "Successfully reserved class(es)." as notice flash message
	And 1 attendances should exist with student: user "johan", klass: klass "klass16"
	And 1 attendances should exist
	#And a mail should exist with subject: "Reservation", message: "You have reserved a class!"
	#And 1 mails should exist
	#And a recipient should exist with user: user "johan", mail: that mail
	#And 1 recipients should exist

@another_class
Scenario: Reserve another class
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "johan"
	And a klass: "klass17" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass16" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass15" exists with date: "2010-02-15", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And an attendance exists with student: user "johan", klass: klass "klass16"
	And an attendance exists with student: user "johan", klass: klass "klass15"
	And a user is logged in as "aya"
When I go to the reserve page for user: "johan" on "2010-03-06"
Then I should see "Classes to Reserve" within "div.reservable"
	And I should not see "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.reservable"
	And I should see "3/19(Friday) - Ruby I - 12:00~13:00" within "div.reservable"
	And I should not see "2/15(Monday) - Ruby I - 12:00~13:00" within "div.reservable"
	And I should see "Reserved Classes" within "div.reserved"
	And I should see "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.reserved"
	And I should not see "3/19(Friday) - Ruby I - 12:00~13:00" within "div.reserved"
	And I should not see "2/15(Monday) - Ruby I - 12:00~13:00" within "div.reserved"
	And I should see "Class History" within "div.history"
	And I should not see "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.history"
	And I should not see "3/19(Friday) - Ruby I - 12:00~13:00" within "div.history"
	And I should see "2/15(Monday) - Ruby I - 12:00~13:00" within "div.history"
When I check "3/19(Friday) - Ruby I - 12:00~13:00"
	And I press "Reserve"
Then 1 attendances should exist with student: user "johan", klass: klass "klass16"
	And 1 attendances should exist with student: user "johan", klass: klass "klass17"
	And 1 attendances should exist with student: user "johan", klass: klass "klass15"
	And 3 attendances should exist


Scenario: If there are no classes to reserve, that section should not be visable
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "johan"
	And a klass: "klass17" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass16" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And an attendance exists with student: user "johan", klass: klass "klass16"
	And an attendance exists with student: user "johan", klass: klass "klass17"
	And a user is logged in as "aya"
When I go to the reserve page for user: "johan" on "2010-03-06"
	Then the page should have no "reservable" section
	And I should see "Reserved Classes" within "div.reserved"
	And I should see "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.reserved"
	And I should see "3/19(Friday) - Ruby I - 12:00~13:00" within "div.reserved"
	And the page should have no "history" section

@allow-rescue
Scenario Outline: Regular users can only see their own reservation page, but admins have no limit
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"
	And a user is logged in as "<user>"
When I go to the reserve page for user: "<user>"
Then I should be redirected to the <own-page>
When I go to the reserve page for user: "prince"
Then I should be redirected to the <other-page>
Examples:
|	user		|	own-page												|	other-page											|
|	thomas	|	events page											|	events page											|
|	prince	|	events page											|	events page											|
|	junko 	|	reserve page for user: "junko"	|	events page											|
|	mika		|	events page											|	events page											|
|	reiko 	|	reserve page for user: "reiko"	|	events page											|
|	aya		 	|	reserve page for user: "aya"		|	reserve page for user: "prince"	|
|	johan 	|	reserve page for user: "johan"	|	reserve page for user: "prince"	|

Scenario: Links on reservation page (NOT IMPLEMENTED)
Given not implemented

Scenario: Include time, 12 from sat to 17 on tue (NOT IMPLEMENTED)
Given not implemented

Scenario: Change to Tokyo time! (NOT IMPLEMENTED)
Given not implemented

Scenario: Implement mailing (NOT IMPLEMENTED)
Given not implemented