Background:
Given a setting exists with name: "main"

Scenario: User confirmation with username
Given a user: "spacecow" exists with username: "spacecow", email: "jsveholm@gmail.com"
When I go to the new reset password page
	And I follow "English"
	And I fill in "User name" with "spacecow"
	And I press "Send"
Then I should see "A mail has been sent to you." within "#notice"
	And I should be redirected to the root page
	And a reset password should exist with user: user "spacecow"
	
Scenario: User confirmation with email
Given a user: "spacecow" exists with email: "jsveholm@gmail.com"
When I go to the new reset password page
	And I follow "English"
	And I fill in "Email address" with "jsveholm@gmail.com"
	And I press "Send"
Then I should see "A mail has been sent to you." within "#notice"
	And I should be redirected to the root page
	And a reset password should exist with user: user "spacecow"

@pending
Scenario: Try to switch language in the middle of an error message (NOT IMPLEMENTED)

Scenario: Errors for the user confirmation form
When I go to path "/login_user"
	And I follow "English"
	And I follow "I have forgotten my password!"
Then I should see "Please provide your username or email and an email will be sent to you with instructions of how to reset your password." within "div.intro"
When I press "Send"
Then I should see "User namecan't both be blank"
	And I should see "Email addresscan't both be blank"
	And I should not see "does not exist"
When I fill in "User name" with "rymdkossan"
	And I press "Send"
Then I should see "User namedoes not exist"	
	And I should not see "Email addressdoes not exist"	
	And I should not see "both be blank"
When I fill in "Email address" with "rymdkossan@space.com"
	And I press "Send"
Then I should see "User namedoes not exist"	
	And I should see "Email addressdoes not exist"	
	And I should not see "both be blank"
When I fill in "User name" with ""
	And I press "Send"
Then I should not see "User namedoes not exist"	
	And I should see "Email addressdoes not exist"		
	And I should not see "both be blank"