Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user exists with username: "thomas", role: "observer", language: "en"
	And a user exists with username: "kurosawa", role: "registrant", language: "ja"
	And a user: "junko" exists with username: "junko", role: "registrant", language: "en"

Scenario: Create new Todo
Given a user is logged in as "junko"
When I go to the new todo page
  And I fill in "Title" with "Chat room"
  And I fill in "Description" with "Wouldn't that be fun!"
  And I check "Bug"
  And I press "Create"
Then I should be redirected to the todos page
  And I should see "Successfully created Todo."
  And a todo should exist with subjects_mask: 1, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"  
  
Scenario: Edit a Todo
Given a todo exists with subjects_mask: 1, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"
	And a user is logged in as "junko"
When I go to the edit page of that todo
	And I fill in "Title" with "Chatter room"
  And I fill in "Description" with "Wouldn't that be even funnier!"
  And I check "Feature"	
	And I press "Update"
Then I should be redirected to the todos page
  And I should see "Successfully updated Todo."
  And a todo should exist with subjects_mask: 5, user: user "junko", title: "Chatter room", description: "Wouldn't that be even funnier!"

Scenario: Delete a Todo and its dependencies
Given a todo exists with subjects_mask: 1, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"
	And a vote exists with todo: that todo, user: user "junko"
	And a comment exists with todo: that todo, user: user "junko", comment: "yeah!"
Then 1 todos should exist
	And 1 comments should exist
	And 1 votes should exist
Given a user is logged in as "junko"
When I go to the edit page of that todo
	And I follow "Del"
Then I should be redirected to the todos page
  And I should see "Successfully deleted Todo."
	And 0 todos should exist
	And 0 comments should exist
	And 0 votes should exist

Scenario: Close a Todo
Given a todo exists with title: "Chat room"
	And a user is logged in as "johan"
When I go to the todos page
Then I should see "Todo List - Open"
Then I should see "Chat room"
When I follow "Close"
Then I should be redirected to the todos page
	And I should see "Todo List - Open"
	And I should not see "Chat room"

Scenario: List a closed/reopened Todo
Given a todo exists with title: "Chat room", closed: true
	And a user is logged in as "johan"
When I go to the todos page
Then I should not see "Chat room"
When I follow "Closed"
Then I should be redirected to the todos page
	And I should see "Todo List - Closed"
	And I should see "Chat room - closed"
When I follow "Re-open"
Then I should be redirected to the todos page
	And I should see "Todo List - Closed"	
	And I should not see "Chat room"
When I follow "Open"
Then I should be redirected to the todos page
	And I should see "Todo List - Open"
	And I should see "Chat room"

Scenario: Show a closed/reopened Todo
Given a todo exists with title: "Chat room"
	And a user is logged in as "johan"
When I go to the show page of that todo
Then I should not see "Chat room - closed"
When I follow "Close"
Then I should be redirected to the show page of that todo
	And I should see "Chat room - closed"
	
Scenario: Re-open a closed Todo
Given a todo exists with title: "Chat room", closed: true
	And a user is logged in as "johan"
When I go to the show page of that todo
Then I should see "Chat room - closed"
When I follow "Re-open"
Then I should be redirected to the show page of that todo
	And I should see "Chat room"


Scenario: Author (NOT IMPLEMENTED)
Given not implemented

Scenario: Cache setting (NOT IMPLEMENTED)
Given not implemented