@manage_voting
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en"
	And a todo: "chat" exists with subjects_mask: 3, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"
	And a todo: "friends" exists with subjects_mask: 2, user: user "prince", title: "Have friends", description: "I want friends for Christmas!"

@allow-rescue
Scenario: Regular registrants should not be able to vote
Given a user is logged in as "mika"
When I go to the votes page
Then I should be redirected to the events page
When I go to the new vote page
Then I should be redirected to the events page

@allow-rescue
Scenario Outline: Regular users should not be able to see the vote index
Given a user is logged in as "<user>"
When I go to the votes page
Then I should be redirected to the events page
Examples:
|	user		|
|	junko		|
|	prince	|

@vote
Scenario Outline: Vote
Given a todo: "chatting" exists with subjects_mask: 3, user: user "<author>", title: "Chatting room", description: "Wouldn't that be fun!"
	And a user is logged in as "<user>"
When I go to the todos page
	And I follow "1" within todo: "chatting"
Then I should be redirected to the todos page
	And I should see "Points: 1" within todo "chatting"
	And a vote should exist with user: user "<user>", todo: todo "chatting", points: 1
	And a mail <johan> exist with sender: user "<user>", subject: "created#vote", message: "votes.created#Chatting room"
	And a recipient <johan> exist with user: user "johan"
	And <no> mails should exist
	And <no> recipients should exist
Examples:
|	author	|	user		|	johan				| no	|
|	junko		|	junko		|	should			|	1		|
|	junko		|	johan		|	should not	|	0		|
|	junko		|	prince	| should			|	1		|
|	johan		|	junko		| should			|	1		|
|	johan		|	johan		|	should not	|	0		|
|	johan		|	prince	|	should			|	1		|

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
	And a user is logged in as "prince"
When I go to the todos page
	And I follow "4" within todo: "chat"
Then 2 votes should exist
	And I should see "Points: 9" within todo "chat"
	And a vote should exist with user: user "junko", todo: todo "chat", points: 5
	And a vote should exist with user: user "prince", todo: todo "chat", points: 4

@change_vote
Scenario Outline: A person can change his vote
Given a todo: "chatting" exists with subjects_mask: 3, user: user "<author>", title: "Chatting room", description: "Wouldn't that be fun!"
	And a vote exists with user: user "<user>", todo: todo "chatting", points: 5
	And a user is logged in as "<user>"
When I go to the todos page
	And I follow "4" within todo: "chatting"
Then 1 votes should exist
	And I should see "Points: 4" within todo "chatting"
	And a vote should exist with user: user "<user>", todo: todo "chatting", points: 4
	And a mail <johan> exist with sender: user "<user>", subject: "changed#vote", message: "votes.changed#Chatting room"
	And a recipient <johan> exist with user: user "johan"
	And <no> mails should exist
	And <no> recipients should exist
Examples:
|	author	|	user		|	johan				| no	|
|	junko		|	junko		|	should			|	1		|
|	junko		|	johan		|	should not	|	0		|
|	junko		|	prince	| should			|	1		|
|	johan		|	junko		| should			|	1		|
|	johan		|	johan		|	should not	|	0		|
|	johan		|	prince	|	should			|	1		|
	
@cancel_vote
Scenario Outline: Cancel a vote
Given a todo: "chatting" exists with subjects_mask: 3, user: user "<author>", title: "Chatting room", description: "Wouldn't that be fun!"
	And a vote exists with user: user "<user>", todo: todo "chatting", points: 5
	And a user is logged in as "<user>"
When I go to the todos page
	And I follow "cancel" within todo: "chatting"
Then 0 votes should exist
	And I should see "Points: 0" within todo "chatting"
	And a mail <johan> exist with sender: user "<user>", subject: "canceled#vote", message: "votes.canceled#Chatting room"
	And a recipient <johan> exist with user: user "johan"
	And <no> mails should exist
	And <no> recipients should exist
Examples:
|	author	|	user		|	johan				| no	|
|	junko		|	junko		|	should			|	1		|
|	junko		|	johan		|	should not	|	0		|
|	junko		|	prince	| should			|	1		|
|	johan		|	junko		| should			|	1		|
|	johan		|	johan		|	should not	|	0		|
|	johan		|	prince	|	should			|	1		|	
	
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