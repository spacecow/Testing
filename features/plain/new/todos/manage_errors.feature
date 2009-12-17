Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user is logged in as "johan"
	And I go to the new todo page
	
Scenario: Cannot be blank
When I press "Create"
Then I should be redirected to the error todos page
	And I should see "Title can't be blank"
	And I should see "Description can't be blank"
	And I should see "Subjects can't be blank"
	And I should not see "User can't be blank"