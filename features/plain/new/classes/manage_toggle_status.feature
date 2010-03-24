@index
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "teacher, admin", language: "en", name: "Aya Komatsu"
	And a course: "ruby" exists with name: "Ruby I"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan", cost: "2500"
	And a courses_teacher exists with course: course "ruby", teacher: user "aya", cost: "2000"
	And a klass: "ruby" exists with course: course "ruby", date: "2010-02-28", start_time: "10:00", end_time: "10:50"
	And a user is logged in as "johan"

@toggle
Scenario: Default status mask for a Teaching
When I browse to the klasses page of "February 28 2010"
	And I select "Aya Komatsu" as teacher within klass "ruby"
	And I press "OK!" within klass "ruby"
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 4
	And 1 teachings should exist

Scenario: Confirm a teacher
Given a teaching exists with klass: klass "ruby", teacher: user "aya", status_mask: 4
When I browse to the klasses page of "February 28 2010"
When I press "?"
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 33
	And 1 teachings should exist

Scenario: Decline a teacher
Given a teaching exists with klass: klass "ruby", teacher: user "aya", status_mask: 33
When I browse to the klasses page of "February 28 2010"
When I press "O"
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 2
	And 1 teachings should exist

Scenario: Choose another teacher
Given a teaching exists with klass: klass "ruby", teacher: user "aya", status_mask: 2
When I browse to the klasses page of "February 28 2010"
	And I select "Johan Sveholm" as teacher within klass "ruby"
	And I press "OK!" within klass "ruby"
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 2, cost: 2000
	And a teaching should exist with klass: klass "ruby", teacher: user "johan", status_mask: 4, cost: 2500
	And 2 teachings should exist

When I press "?"
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", current: false, status_mask: 2, cost: "2000"
	And a teaching should exist with klass: klass "ruby", teacher: user "johan", current: true, status_mask: 1, cost: "2500"
	And 2 teachings should exist
When I select "Aya Komatsu" as teacher within klass "ruby"
	And I press "OK!" within klass "ruby"
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", current: true, status_mask: 2, cost: "2000"
	And a teaching should exist with klass: klass "ruby", teacher: user "johan", current: false, status_mask: 1, cost: "2500"
	And 2 teachings should exist	