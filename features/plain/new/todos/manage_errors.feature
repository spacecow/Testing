@manage_errors
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "admin, teacher", language: "en"
	And a user is logged in as "johan"
	And I go to the new todo page
	
Scenario: Cannot be blank
When I press "Create"
Then I should be redirected to the error todos page
	And I should see "Title can't be blank"
	And I should see "Description can't be blank"
	And I should see "Subjects can't be blank"
	And I should not see "User can't be blank"
	
Scenario: Title must be unique
Given a todo exists with subjects_mask: 7, user: user "johan", title: "Chat room", description: "Wouldn't that be fun!"
When I fill in "Title" with "Chat room"
	And I press "Create"
Then I should be redirected to the error todos page
	And I should see "Title*has already been taken"