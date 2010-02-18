Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"

Scenario: View of a user's courses page
Given a course exists with name: "Rails II"
	And a course exists with name: "Ruby III"
	And a course exists with name: "Fortran I"
	And a user is logged in as "aya"
When I go to the courses page for user: "johan"
Then I should see "Enlisted Courses" as title
	And I should see "Ruby V"
	
Scenario: Sort classes in order (NOT IMPLEMENTED)
Given not implemented