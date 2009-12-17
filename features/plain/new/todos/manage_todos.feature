Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user exists with username: "thomas", role: "observer", language: "en"
	And a user exists with username: "kurosawa", role: "registrant", language: "ja"
	And a user: "junko" exists with username: "junko", role: "registrant", language: "en"
	
Scenario Outline: Linking from index page
Given a user is logged in as "<user>"
When I go to the todos page
Then I should be redirected to the todos page
	And I follow "<link>"
Then I should be redirected to the new todo page
Examples:
| user 			| link          |
| johan			|	New Todo      |
| thomas		|	New Todo      |
| kurosawa  | 新しいやる事  |

Scenario Outline: Index page
Given a user is logged in as "<user>"
When I go to the todos page
Then I should see "<title>" within "h1"
Examples:
| user 			| title  |
| junko 		|	Todos  |
| kurosawa  | やる事 |

Scenario: Create new Todo
Given a user is logged in as "junko"
When I go to the new todo page
  And I fill in "Title" with "Chat room"
  And I fill in "Description" with "Wouldn't that be fun!"
  And I check "Bug"
  And I press "Create"
Then I should be redirected to the todos page
  And I should see "Successfully created Todo."
  And a todo should exist with user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"  