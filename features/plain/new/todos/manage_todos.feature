@todos
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "admin, teacher", language: "en", name: "Johan Sveholm"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en"
	And a user exists with username: "kurosawa", role: "registrant, student", language: "ja"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en"

@allow-rescue
Scenario: Regular registrants should not be able to see the Todo page
Given a user is logged in as "mika"
When I go to the new todo page
Then I should be redirected to the events page
When I go to the todos page
Then I should be redirected to the events page

@new
Scenario Outline: Create new todo
Given a user is logged in as "<user>"
When I go to the new todo page
  And I fill in "Title" with "Chat#room"
  And I fill in "Description" with "Wouldn't that be fun!"
  And I check "Bug"
  And I press "Create"
Then I should be redirected to the todos page
  And I should see "Successfully created todo."
  And a todo should exist with subjects_mask: 1, user: user "<user>", title: "Chat*room", description: "Wouldn't that be fun!"
  And <no> mails should exist
  And a mail <johan> exist with sender: user "junko", subject: "created#todo", message: "todos.created#Chat*room##"
  And <no> recipients should exist
  And a recipient <johan> exist with user: user "johan"
Examples:
|	user	|	johan				|	no	|
|	junko	|	should			|	1		|	
|	johan	|	should not	|	0		|
  
@edit
Scenario Outline: Edit a Todo
Given a todo exists with subjects_mask: 1, user: user "junko", title: "Chat#room", description: "Wouldn't that be fun!<br />yeah!"
	And a user is logged in as "<user>"
When I go to the edit page of that todo
Then the "Description" field should not contain "Wouldn't that be fun! yeah!"
	And the "Description" field should contain "Wouldn't that be fun!"
	And the "Description" field should contain "yeah!"	
	And the "Title" field should contain "Chat\*room"
When I fill in "Title" with ""
	And I press "Update"
Then the "Description" field should not contain "Wouldn't that be fun!&lt;br /&gt;"
	And the "Description" field should contain "Wouldn't that be fun!\n"
When I fill in "Title" with "Chatter#room"
  And I check "Feature"	
	And I press "Update"
Then I should be redirected to the todos page
  And I should see "Successfully updated todo."
  And a todo should exist with subjects_mask: 5, user: user "junko", title: "Chatter*room", description: "Wouldn't that be fun!<br />"
  And <no> mails should exist
  And a mail <johan> exist with sender: user "<user>", subject: "updated#todo", message: "todos.updated#Chatter*room##"
  And <no> recipients should exist
  And a recipient <johan> exist with user: user "johan"
Examples:
|	user	|	johan				|	no	|
|	junko	|	should			|	1		|
|	johan	|	should not	|	0		|

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
  And I should see "Successfully deleted todo."
	And 0 todos should exist
	And 0 comments should exist
	And 0 votes should exist

Scenario: If the creator of the todo is deleted, the todo is not deleted
Given a todo exists with user: user "junko", subjects_mask: 1, title: "Chat room"
	And a user is logged in as "johan"
When I go to the users page
	And I follow "Del" within user "junko"
	And I go to the todos page
Then I should see "Anonymous" within "span.creator"
When I follow "Chat room" within "div.header div.title"
Then I should see "Anonymous" within "span.creator"

@close
Scenario Outline: Close a Todo
Given a todo exists with title: "Chat room", subjects_mask: 1, user: user "<author>"
	And a comment exists with todo: that todo, user: user "junko", comment: "yeah!"
	And a vote exists with todo: that todo, user: user "mika"
	And a user is logged in as "<user>"
When I go to the todos page
Then I should see "Todo List - Open"
Then I should see "Chat room"
When I follow "Close"
Then I should be redirected to the todos page
	And I should see "Todo List - Open"
	And I should not see "Chat room"
	And 1 mails should exist
	And <no> recipients should exist
	And a mail: "close" should exist with sender: user "<user>", subject: "closed#todo", message: "todos.closed#Chat room##"	
	And a recipient <johan> exist with user: user "johan", mail: mail "close"
	And a recipient <other> exist with user: user "<author>", mail: mail "close"
	And a recipient <comment> exist with user: user "junko", mail: mail "close"
	And a recipient <vote> exist with user: user "mika", mail: mail "close"
Examples:
|	user		|	author	|	johan				|	other				|	comment			|	vote		| no	|
|	junko		|	junko		|	should			|	should not	|	should not	|	should	| 2		|
|	johan		|	johan		| should not	|	should not	|	should			|	should	| 2		|
|	johan		|	junko		| should not	|	should			|	should			|	should	| 2		|
|	thomas	|	thomas	| should 			|	should not	|	should			|	should	| 3		|
|	johan		|	thomas	| should not	|	should 			|	should			|	should	| 3		|

Scenario: Show a closed/reopened Todo
Given a todo exists with title: "Chat room", subjects_mask: 1
	And a user is logged in as "johan"
When I go to the show page of that todo
Then I should not see "Chat room - closed"
When I follow "Close"
Then I should be redirected to the show page of that todo
	And I should see "Chat room - closed"

@open
Scenario Outline: Re-open a closed Todo
Given a todo exists with title: "Chat room", closed: true, subjects_mask: 1, user: user "<author>"
	And a comment exists with todo: that todo, user: user "junko", comment: "yeah!"
	And a vote exists with todo: that todo, user: user "mika"
	And a user is logged in as "<user>"
When I go to the show page of that todo
Then I should see "Chat room - closed"
When I follow "Re-open"
Then I should be redirected to the show page of that todo
	And I should see "Chat room"
	And 1 mails should exist
	And <no> recipients should exist
	And a mail: "reopen" should exist with sender: user "<user>", subject: "reopened#todo", message: "todos.reopened#Chat room##"	
	And a recipient <johan> exist with user: user "johan", mail: mail "reopen"
	And a recipient <other> exist with user: user "<author>", mail: mail "reopen"
	And a recipient <comment> exist with user: user "junko", mail: mail "reopen"
	And a recipient <vote> exist with user: user "mika", mail: mail "reopen"
Examples:
|	user		|	author	|	johan				|	other				|	comment			|	vote		| no	|
|	junko		|	junko		|	should			|	should not	|	should not	|	should	| 2		|
|	johan		|	johan		| should not	|	should not	|	should			|	should	| 2		|
|	johan		|	junko		| should not	|	should			|	should			|	should	| 2		|
|	thomas	|	thomas	| should 			|	should not	|	should			|	should	| 3		|
|	johan		|	thomas	| should not	|	should 			|	should			|	should	| 3		|
	
@pending
Scenario: Get rid of the error box, add errors to subjects (NOT IMPLEMENTED)

@pending
Scenario: Closed/Open - better names in Japanese, make it easier to understand (NOT IMPLEMENTED)

@pending
Scenario: Button for update comment doesnt look pretty (NOT IMPLEMENTED)

@pending
Scenario: Todo List should go to closed if you are at the show page of a closed todo (NOT IMPLEMENTED)

@pending
Scenario: Johan should not send a mail to himself when he creates a todo (NOT IMPLEMENTED)
