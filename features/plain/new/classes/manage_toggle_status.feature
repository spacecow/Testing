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

@no_teaching
Scenario: If no teacher is selected, no teaching should be created
When I browse to the klasses page of "February 28, 2010"
	And I press "OK!" within klass "ruby"
Then 0 teachings should exist
	
@toggle
Scenario: Default status mask for a Teaching
When I browse to the klasses page of "February 28, 2010"
	And I select "Aya Komatsu" as teacher within klass "ruby"
	And I press "OK!" within klass "ruby"
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 4
	And 1 teachings should exist

@confirm
Scenario: Confirm a teacher
Given a teaching exists with klass: klass "ruby", teacher: user "aya", status_mask: 4
When I browse to the klasses page of "February 28, 2010"
When I press the confirm button
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 33
	And 1 teachings should exist
	And I should see a teach button
	And the teacher select menu should be disabled

@taught
Scenario: Confirm a teacher having taught the class
Given a teaching exists with klass: klass "ruby", teacher: user "aya", status_mask: 33
When I browse to the klasses page of "February 28, 2010"
When I press the teach button
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 9
	And 1 teachings should exist
	And the confirm button should be disabled

Scenario: Confirm a teacher having canceled his class
Given a teaching exists with klass: klass "ruby", teacher: user "aya", status_mask: 9
When I browse to the klasses page of "February 28, 2010"
When I press the teach button
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 17
	And 1 teachings should exist
	And the confirm button should be disabled

Scenario: Toggle the class back to untaught
Given a teaching exists with klass: klass "ruby", teacher: user "aya", status_mask: 17
When I browse to the klasses page of "February 28, 2010"
When I press the teach button
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 33
	And 1 teachings should exist
	And the confirm button should not be disabled

@decline
Scenario: Decline a teacher
Given a teaching exists with klass: klass "ruby", teacher: user "aya", status_mask: 33
When I browse to the klasses page of "February 28, 2010"
When I press the confirm button
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 2
	And 1 teachings should exist
	And I should see no teach button

Scenario: Unconfirm a teacher
Given a teaching exists with klass: klass "ruby", teacher: user "aya", status_mask: 2
When I browse to the klasses page of "February 28, 2010"
When I press the confirm button
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 4
	And 1 teachings should exist
	And I should see no teach button
	
@another
Scenario: Choose another teacher
Given a teaching exists with klass: klass "ruby", teacher: user "aya", status_mask: 2
When I browse to the klasses page of "February 28, 2010"
	And I select "Johan Sveholm" as teacher within klass "ruby"
	And I press "OK!" within klass "ruby"
Then a teaching should exist with klass: klass "ruby", teacher: user "aya", status_mask: 2, cost: 2000
	And 1 teachings should exist with klass: klass "ruby", teacher: user "johan", status_mask: 4, cost: 2500
	And 2 teachings should exist

#When I press "?"
#Then a teaching should exist with klass: klass "ruby", teacher: user "aya", current: false, status_mask: 2, cost: "2000"
#	And a teaching should exist with klass: klass "ruby", teacher: user "johan", current: true, status_mask: 1, cost: "2500"
#	And 2 teachings should exist
#When I select "Aya Komatsu" as teacher within klass "ruby"
#	And I press "OK!" within klass "ruby"
#Then a teaching should exist with klass: klass "ruby", teacher: user "aya", current: true, status_mask: 2, cost: "2000"
#	And a teaching should exist with klass: klass "ruby", teacher: user "johan", current: false, status_mask: 1, cost: "2500"
#	And 2 teachings should exist	