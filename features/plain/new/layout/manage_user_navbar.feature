Background:
Given a setting exist with name: "main"

Scenario: The user navigation bar for students
Given a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"	
	And a user is logged in as "junko"
Then I should see commands "Reserve, Edit Profile, Logout, Mail" in the user navigation bar