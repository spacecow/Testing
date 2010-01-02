Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "registrant", language: "en"
	And a user: "junko" exists with username: "junko", role: "registrant", language: "en"
	And a todo: "chat" exists with subjects_mask: 3, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"
	And a todo: "friends" exists with subjects_mask: 2, user: user "johan", title: "Have friends", description: "I want friends for Christmas!"
	
Scenario: Vote
Given a user is logged in as "junko"
When I go to the todos page
	And I follow "1" within todo: "chat"
Then I should be redirected to the todos page
	And I should see "Points: 1" within todo "chat"
	And a vote should exist with user: user "junko", todo: todo "chat", points: 1

Scenario: A person can vote for another todo
Given a vote exists with user: user "junko", todo: todo "chat", points: 2
	And a user is logged in as "junko"
When I go to the todos page
	And I follow "3" within todo: "friends"
Then 2 votes should exist
	And I should see "Points: 2" within todo "chat"
	And I should see "Points: 3" within todo "friends"
	And a vote should exist with user: user "junko", todo: todo "chat", points: 2
	And a vote should exist with user: user "junko", todo: todo "friends", points: 3

Scenario: Another person can vote for a todo that already have been voted for
Given a vote exists with user: user "junko", todo: todo "chat", points: 5
	And a user is logged in as "johan"
When I go to the todos page
	And I follow "4" within todo: "chat"
Then 2 votes should exist
	And I should see "Points: 9" within todo "chat"
	And a vote should exist with user: user "junko", todo: todo "chat", points: 5
	And a vote should exist with user: user "johan", todo: todo "chat", points: 4

Scenario: A person can change his vote
Given a vote exists with user: user "junko", todo: todo "chat", points: 5
	And a user is logged in as "junko"
When I go to the todos page
	And I follow "4" within todo: "chat"
Then 1 votes should exist
	And I should see "Points: 4" within todo "chat"
	And a vote should exist with user: user "junko", todo: todo "chat", points: 4
	
Scenario: Cancel a vote
Given a vote exists with user: user "junko", todo: todo "chat", points: 5
	And a user is logged in as "junko"
When I go to the todos page
	And I follow "cancel" within todo: "chat"
Then 0 votes should exist
	And I should see "Points: 0" within todo "chat"
	
Scenario: Vote on the show page
Given a user is logged in as "junko"
When I go to the show page of todo: "chat"
	And I follow "1" within todo: "chat"
Then I should be redirected to the show page of todo: "chat"
	And I should see "Points: 1" within todo "chat"
	And a vote should exist with user: user "junko", todo: todo "chat", points: 1

Scenario: Cancel a vote on the show page
Given a vote exists with user: user "junko", todo: todo "chat", points: 5
	And a user is logged in as "junko"
When I go to the show page of todo: "chat"
	And I follow "cancel" within todo: "chat"
Then I should be redirected to the show page of todo: "chat"
	And 0 votes should exist
	And I should see "Points: 0" within todo "chat"

Scenario: Make voting AJAX! (NOT IMPLEMENTED)
Given not implemented