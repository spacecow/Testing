Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", cost: "0"
	And a user: "aya" exist with username: "aya", role: "admin, teacher"
	And a user: "hitomi" exist with username: "hitomi", role: "admin, teacher", cost: ""
	And a user is logged in as "johan"
	
Scenario: Tables for the staff should not be visible by default
When I browse to the salary users page for "January"
Then the "johan" id should not exist for "table"
	And the "aya" id should not exist for "table"
	And the "hitomi" id should not exist for "table"