@voting
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "admin", language: "en", name: "Johan"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant", language: "en", name: "Kurosawa"
	And a todo: "chat" exists with subjects_mask: 1, title: "Chat room"
	And a todo: "password" exists with subjects_mask: 1, title: "Reset password"
	And a todo: "yeah" exists with subjects_mask: 1, title: "Yeah"
	And a vote exists with user: user "johan", todo: todo "chat", points: 5
	And a vote exists with user: user "kurosawa", todo: todo "chat", points: 2
	And a vote exists with user: user "kurosawa", todo: todo "password", points: 3

Scenario: List votes
Given a user is logged in as "johan"
When I go to the votes page
Then I should see todo "chat" table
|	User	|	Points	| When										|
|	Johan			|	5				|	less than a minute ago	|
|	Kurosawa	|	2				|	less than a minute ago	|
And I should see todo "password" table
|	User	|	Points	| When										|
|	Kurosawa	|	3				|	less than a minute ago	|
And I should not see "Yeah"