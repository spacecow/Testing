Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user exists with username: "thomas", role: "observer", language: "en"
	And a user: "junko" exists with username: "junko", role: "registrant", language: "en", name: "Junko"
	
Scenario Outline: Contents of the show page
Given a user is logged in as "<user>"
	And a todo exists with subjects_mask: 1, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"  
When I go to the show page of that todo
Then I should see "Chat room" within "legend"
	And I should see "Wouldn't that be fun!" within "div.contents"
	And I should see "<subject>" within "div.bug"
	And I should see "Junko" within "div.author"
	And I should <index> "Todo List" within "div.links"
	And I should <edit> "Edit" within "div.links"
	And I should <delete> "Del" within "div.links"
Examples:
| user 			|	subject	|	edit		| delete 	| index |
| junko 		|	bug			|	see			|	see			|	see		|
| johan 		|	bug			|	see			|	see			|	see		|
| thomas 		|	bug			| not see	| not see |	see		|