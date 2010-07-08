Background:
Given a setting exist with name: "main"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "johan" exists with username: "johan", role: "god, teacher, student", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "johan"
	And a klass: "19" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "18" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	
@reserve
Scenario: Reserve a class
Given a user is logged in as "aya"
When I go to the reserve page for user: "johan" on "2010-03-06"
Then I should see "Johan Sveholm - Reserve" as title
	And I should see "Classes to Reserve" within "div.reservable"
	And I should see "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.reservable"
	And I should see "3/19(Friday) - Ruby I - 12:00~13:00" within "div.reservable"
	And the page should have no "reserved" section
	And the page should have no "history" section

@reserved @late
Scenario: List already reserved classes if student goes to the page at a time when they cannot reserve
Given an attendance exist with student: user "johan", klass: klass "18"
	And a user is logged in as "aya"
When I go to the reserve page for user: "johan" on "2010-03-17"
Then I should see "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.reserved"

@reserved @cancel
Scenario Outline: Canceled classes should not show up in reserved classes unless admin
Given an attendance exist with student: user "junko", klass: klass "18", cancel: true
	And an attendance exist with student: user "junko", klass: klass "19"
	And a user is logged in as "<user>"
When I go to the reserve page for user: "junko" on "2010-03-17"
Then I should <canceled> "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.reserved"
Examples:
|	user	|	canceled	|
|	junko	|	not see		|
|	aya		|	see				|

@history @cancel @absent
Scenario Outline: Canceled&absent classes should not show up in history unless admin
Given a klass: "15" exists with date: "2010-03-15", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And an attendance exist with student: user "junko", klass: klass "15", absent: true
	And an attendance exist with student: user "junko", klass: klass "18", cancel: true
	And an attendance exist with student: user "junko", klass: klass "19"
	And a user is logged in as "<user>"
When I go to the reserve page for user: "junko" on "2010-03-20"
Then I should <away> "3/15(Monday) - Ruby I - 12:00~13:00" within "div.history"
Then I should <away> "3/18(Thursday) - Ruby I - 12:00~13:00" within "div.history"
Examples:
|	user	|	away			|
|	junko	|	not see		|
|	aya		|	see				|

@reserved @history @reserve
Scenario: Classes in Reserved and History should not cease to exist if another reservation is made
Given a klass: "15" exists with date: "2010-02-15", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And an attendance exists with student: user "johan", klass: klass "18"
	And an attendance exists with student: user "johan", klass: klass "15"
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