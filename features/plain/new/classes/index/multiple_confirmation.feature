@index
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "teacher, admin", language: "en", name: "Aya Komatsu"
	And a user is logged in as "johan"

Scenario: yeah
Given a course exists with name: "Ruby I"
	And a klass: "1" exists with todays date with course: that course
	And a klass: "2" exists with todays date with course: that course
	And a courses_teacher exists with course: that course, teacher: user "johan"
	And a courses_teacher exists with course: that course, teacher: user "aya"
When I go to the klasses page
	And I select "Johan Sveholm" as teacher within klass "1"
	And I select "Aya Komatsu" as teacher within klass "2"
	And I press "Update" within "Ruby"
Then a teaching should exist with klass: "1", teacher: user "johan", status_mask: 4
Then a teaching should exist with klass: "2", teacher: user "aya", status_mask: 4