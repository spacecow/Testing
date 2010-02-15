Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	
Scenario: Reserve a class
Given a user is logged in as "johan"
When I go to the reserve klasses page