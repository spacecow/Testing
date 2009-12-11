Background:
Given a setting exists with name: "main"

Scenario: Only Johan can send out invitations so far
Given a user exists with username: "johan", role: "god", language: "en"
	And a user is logged in as "johan"
When I go to the events page
	And I follow "Send Invitation"
Then I should be redirected to the new invitation page

Scenario: If you are not Johan, you cannot send out invitations
Given a user exists with username: "aya", role: "admin", language: "en"
	And a user is logged in as "aya"
When I go to the events page
Then I should not see "Send Invitation"


Scenario: Send an invitation
Given a user: "johan" exists with username: "johan", role: "god", language: "en", invitation_limit: 5
	And a user is logged in as "johan"
When I go to the new invitation page
	And I fill in "Email Address*" with "jsveholm@gmail.com"
	And I press "Send"
Then I should be redirected to the root page
	And I should see "Invitation sent"
	And an invitation should exist with sender: user "johan"
	And a user should exist with invitation_limit: 4