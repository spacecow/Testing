Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user exists with username: "thomas", role: "observer", language: "en"
	And a user exists with username: "kurosawa", role: "registrant", language: "ja"
	And a user: "junko" exists with username: "junko", role: "registrant", language: "en", name: "Junko"
	
Scenario: Linking from index page
Given a user is logged in as "junko"
	And a todo exists with subjects_mask: 1, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"
When I go to the todos page
Then I should be redirected to the todos page
	And I follow "New Todo"
Then I should be redirected to the new todo page
When I go to the todos page
	And I follow "Chat room"
Then I should be redirected to the show page of that todo
When I go to the todos page
	And I follow "Junko" within "div.author"
Then I should be redirected to the show page of that user
When I go to the todos page
	And I follow "Edit" within "div.links"
Then I should be redirected to the edit page of that todo
When I go to the todos page
	And I follow "Del"
Then I should be redirected to the todos page
	And 0 todos should exist


Scenario Outline: Contents of the index page
Given a user is logged in as "<user>"
	And a todo exists with subjects_mask: 1, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"  
When I go to the todos page
Then I should see "<title>" within "h1"
	And I should see "Chat room" within "h3"
	And I should see "Wouldn't that be fun!" within "div.contents"
	And I should see "<subject>" within "div.bug"
	And I should see "Junko" within "div.author"
	And I should <edit> "Edit" within "div.links"
	And I should <delete> "Del" within "div.links"
Examples:
| user 			| title  |	subject	|	edit		| delete 	|
| junko 		|	Todos  |	bug			|	see			|	see			|
| kurosawa  | やる事 |	バグ		|	not see	|	not see	|
| johan 		|	Todos  |	bug			|	see			|	see			|
|	thomas		|	Todos		| bug			| not see	| not see |