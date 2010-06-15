Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	
@switch
Scenario: When switching teachers, the teaching should remain
Given a course: "ruby" exists with name: "Ruby I"
	And a klass: "ruby" exists with course: course "ruby", date: "2010-02-28"
	And a user is logged in as "johan"
When I browse to the klasses page of "February 28, 2010"
	And I press "OK!" within klass "ruby"
