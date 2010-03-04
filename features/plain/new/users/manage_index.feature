Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "god, teacher", language: "en"
	
Scenario: View of users
Given a user is logged in as "johan"
When I go to the users page
Then I should see a button "Roles"
	And I should not see a button "Courses"