Background:
Given a setting exists with name: "main", version: "0.19"
	And a user: "johan" exists with username: "johan", role: "god", language: "en", invitation_limit: 5
	And a user exists with username: "aya", role: "admin", language: "en"

Scenario: Only Johan can send out invitations so far
Given a user is logged in as "johan"
When I go to the events page
	And I follow "Send Invitation"
Then I should be redirected to the new invitation page

Scenario: If you are not Johan, you cannot send out invitations
Given a user is logged in as "aya"
When I go to the events page
Then I should not see "Send Invitation"

Scenario: Send an invitation
Given a user is logged in as "johan"
When I go to the new invitation page
	And I fill in "Email Address*" with "jsveholm@gmail.com"
	And I press "Send"
Then I should be redirected to the new invitation page
	And I should see "Invitation sent"
	And an invitation should exist with sender: user "johan"
	And a user should exist with invitation_limit: 4

@update
Scenario: Send out information about updates
Given a user is logged in as "johan"
When I go to the new invitation page
	And I press "Send to all"
Then 1 mails should exist
	And a mail: "update" should exist with sender: user "johan", subject: "version_update#version#0.19", message: "* English is English!<br />* 日本語は日本語！<br /><br />"
	And a recipient should exist with user: user "johan", mail: mail "update"

Scenario: Have a version page where updates are listed (NOT IMPLEMENTED)
Given not implemented