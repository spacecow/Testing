Background:
Given a setting exist with name: "main"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "johan" exists with username: "johan", role: "god, teacher, student", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "johan"
	And a klass: "19" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "18" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	



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
