@roles
Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user: "thomas" exists with username: "thomas", role: "observer", language: "en"
	
Scenario: Add a role to a user
Given a user is logged in as "johan"
When I go to the users page
	And I follow "Role" within user: "thomas"
Then a user should exist with username: "thomas", roles_mask: 4
	And the "Observer" checkbox should be checked
When I check "Photographer"
	And I press "Update"
Then I should be redirected to the users page
	And a user should exist with username: "thomas", roles_mask: 68
And I follow "Role" within user: "thomas"