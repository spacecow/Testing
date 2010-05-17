@users
Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user: "thomas" exists with username: "thomas", role: "observer", language: "en"
	
Scenario: Delete a user and his dependencies
Given a user is logged in as "johan"
	And an event exists	
	And a comment exist with event: that event, user: user "thomas"
	And a registrant exist with event: that event, user: user "thomas"
	And a todo exists with user: user "thomas", subjects_mask: 1
	And a comment exist with todo: that todo, user: user "thomas"
	And a vote exists with todo: that todo, user: user "thomas"
Then 1 events should exist
	And 1 todos should exist
	And 2 comments should exist
	And 1 votes should exist
	And 2 users should exist
When I go to the users page
	And I follow "Del" within user: "thomas"
Then 1 events should exist
	And 1 todos should exist
	And 0 comments should exist
	And 0 votes should exist
	And 1 users should exist

@pending
Scenario: Permalinks (NOT IMPLEMENTED)