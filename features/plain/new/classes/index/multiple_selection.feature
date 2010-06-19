@index
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "teacher, admin", language: "en", name: "Aya Komatsu"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a course exists with name: "Ruby I"
	And a klass: "1" exists with todays date with course: that course
	And a klass: "2" exists with todays date with course: that course
	And a courses_teacher exists with course: that course, teacher: user "johan"
	And a courses_teacher exists with course: that course, teacher: user "aya"
	And a courses_teacher exists with course: that course, teacher: user "thomas"
	And a courses_teacher exists with course: that course, teacher: user "prince"	
	And a user is logged in as "johan"

Scenario: Update multiple teachers for non-existing teachings
When I go to the klasses page
	And I select "Johan Sveholm" as teacher within klass "1"
	And I select "Aya Komatsu" as teacher within klass "2"
	And I press "Update" within "Ruby"
Then a teaching should exist with klass: klass "1", teacher: user "johan", status_mask: 4, current: true
	And a teaching should exist with klass: klass "2", teacher: user "aya", status_mask: 4, current: true
	And 2 teachings should exist

Scenario: Update multiple teachers for existing teachings
Given a teaching exists with klass: klass "1", teacher: user "johan", status_mask: 4
	And a teaching exists with klass: klass "2", teacher: user "aya", status_mask: 4
When I go to the klasses page
	And I select "Thomas Osburg" as teacher within klass "1"
	And I select "Prince Philip" as teacher within klass "2"
	And I press "Update" within "Ruby"
Then a teaching should exist with klass: klass "1", teacher: user "thomas", status_mask: 4, current: true
	And a teaching should exist with klass: klass "2", teacher: user "prince", status_mask: 4, current: true
	And a teaching should exist with klass: klass "1", teacher: user "johan", status_mask: 4, current: false
	And a teaching should exist with klass: klass "2", teacher: user "aya", status_mask: 4, current: false
	And 4 teachings should exist
	
Scenario: Individual update should not trigger multiple
When I go to the klasses page
	And I select "Johan Sveholm" as teacher within klass "1"
	And I select "Aya Komatsu" as teacher within klass "2"
	And I press "OK!" within klass "1"
Then a teaching should exist with klass: klass "1", teacher: user "johan", status_mask: 4, current: true
	And 1 teachings should exist
	
