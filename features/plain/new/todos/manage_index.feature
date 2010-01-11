@todos_index
Background:
Given a setting exists with name: "main", todos_description_en: "A long todo description"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user exists with username: "thomas", role: "observer", language: "en"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant", language: "ja", name: "Akira Kurosawa"
	And a user: "junko" exists with username: "junko", role: "registrant", language: "en", name: "Junko"
	
Scenario: Linking from index page as creator of a Todo
Given a user is logged in as "junko"
	And a todo exists with subjects_mask: 1, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"
When I go to the todos page
Then I should be redirected to the todos page
	And I should not see "Edit" within "div.intro"
When I follow "New Todo"
Then I should be redirected to the new todo page
When I go to the todos page
	And I follow "Chat room" within "div.header div.title"
Then I should be redirected to the show page of that todo
When I go to the todos page
	And I follow "Junko" within "div.header"
Then I should be redirected to the show page of that user
When I go to the todos page
	And I follow "Edit" within "div.links"
Then I should be redirected to the edit page of that todo
When I go to the todos page
	And I follow "Del"
Then I should be redirected to the todos page
	And 0 todos should exist

Scenario: Linking from index page as admin
Given a user is logged in as "johan"
When I go to the todos page
	And I follow "Edit" within "div.intro"
Then I should be redirected to the edit page of that setting

@sorting
Scenario Outline: Contents of the index page
Given a user is logged in as "<user>"
	And a todo: "todo1" exists with subjects_mask: 1, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"
	And a todo: "todo2" exists with subjects_mask: 1, closed: true
	And a comment exists with todo: todo "todo2", user: user "kurosawa"
When I go to the todos page
Then I should see "Todo List - Open" within "h1"
	And "status" should have options "Open, Closed"
	And "subject" should have options "All, Bug, Spelling, Feature"
	And "sort" should have options "Points, Latest, Latest comment"
	And "order" should have options "Descending, Ascending"
	And I should see "A long todo description" within "div.intro"
	And I should see "Chat room" within "div.header div.title"
	And I should see "By: Junko" within "span.creator"
	And I should see "Wouldn't that be fun!" within "div.contents"
	And I should see "bug" within "div.bug"
	And I should <close> "Close" within "div.links"
	And I should <edit> "Edit" within "div.links"
	And I should <delete> "Del" within "div.links"
	And I should see "0 comments" within todo "todo1"
When I select "Closed" from "Sort"
	And I press "Go!"	
Then I should see "1 comment" within todo "todo2"
	And I should see "last comment: Akira Kurosawa" within todo "todo2"
Examples:
| user 			|	close		|	edit		| delete 	|
| junko 		|	see			|	see			|	see			|
| johan 		|	see			|	see			|	see			|
|	thomas		|	not see	| not see	| not see |

Scenario: If only one Todo description is set, that one is showed no matter what
Given a user is logged in as "kurosawa"
When I go to the todos page
Then I should see "A long todo description"

Scenario: List a closed/reopened Todo
Given a todo exists with title: "Chat room", closed: true, subjects_mask: 1
	And a user is logged in as "johan"
When I go to the todos page
Then I should not see "Chat room"
When I select "Closed" from "Sort"
	And I press "Go!"
Then I should be redirected to the todos page
	And I should see "Todo List - Closed"
	And I should see "Chat room - closed"
When I follow "Re-open" within that todo
Then I should be redirected to the todos page
#This should work
#	And I should see "Todo List - Closed"	
#	And I should not see "Chat room"
#When I follow "Open"
#Then I should be redirected to the todos page
	And I should see "Todo List - Open"
	And I should see "Chat room"
	
Scenario: Implement a search function (NOT IMPLEMENTED)
Given not implemented