Scenario: Add a comment
Given a setting exists with name: "main"
	And a user exist with username: "johan"
When I browse to "login_user"
	And I type in "User name" with "johan"
	And I type in "Password" with "secret""
  And I press button "Login"