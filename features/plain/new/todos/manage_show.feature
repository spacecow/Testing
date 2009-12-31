Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user exists with username: "thomas", role: "observer", language: "en"
	And a user: "junko" exists with username: "junko", role: "registrant", language: "en", name: "Junko"
	
Scenario Outline: Contents of the show page
Given a user is logged in as "<user>"
	And a todo exists with subjects_mask: 7, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"
When I go to the show page of that todo
Then I should see "Chat room" within "div.header"
	And I should see "By: Junko" within "div.header"
	And I should see "Wouldn't that be fun!" within "div.contents"
	And I should see "bug" within "div.bug"
	And I should see "spelling" within "div.spelling"
	And I should see "feature" within "div.feature"
	And I should <index> "Todo List" within "div.links"
	And I should <edit> "Edit" within "div.links"
	And I should <delete> "Del" within "div.links"
Examples:
| user 			|	edit		| delete 	| index |
| junko 		|	see			|	see			|	see		|
| johan 		|	see			|	see			|	see		|
| thomas 		| not see	| not see |	see		|