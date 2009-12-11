Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "god", language: "en", invitation_limit: 0
	And a user is logged in as "johan"
	And I go to the new invitation page

Scenario: The recipient email address must look like an email address
When I fill in "Email Address*" with "fake_email"
	And I press "Send"
Then I should see "Recipient email must be valid"

Scenario: A user with the email in question is already registered
Given a user exists with email: "kalas@pung.se"
When I fill in "Email Address*" with "kalas@pung.se"
	And I press "Send"
Then I should see "Recipient email is already registered"

Scenario: The sender must have invitations to send in order to do that
When I press "Send"
Then I should see "You have reached your limit of invitations to send"