@manage_show
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "admin, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "reiko" exists with username: "reiko", role: "registrant, student", language: "en", name: "Reiko Arikawa"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "god" exists with username: "god", role: "god, teacher", language: "en", name: "God Almighty"
	And a todo exists with subjects_mask: 1, title: "Chat room"

@regular_mail
Scenario: List an empty mail
Given a mail exists with recipient: user "thomas", sender: user "johan", subject: "no_subject", message: ""
	And a user is logged in as "thomas"
When I go to the show page of that mail
Then I should see "<no subject>" within "legend"
	And I should not see "en, <no subject>" within "legend"
	And I should see "SenderJohan Sveholm"
	And I should see "RecipientThomas Osburg"
	And I should see "Sent atless than a minute ago"
	
Scenario: List a regular mail
Given a mail exists with recipient: user "johan", sender: user "junko", subject: "A boring subject", message: "A boring message"
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "A boring subject" within "legend"
	And I should not see "en, A boring subject" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "A boring message"
	And I should not see "en, A boring message"

Scenario: List mail, Vote created
Given a mail exists with sender: user "junko", recipient: user "johan", subject: "created#vote", message: "votes.created#Chat room"
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "Vote created" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "Junko Sumii has voted for:'Chat room'"

Scenario: List mail, Todo created
Given a mail exists with sender: user "junko", recipient: user "johan", subject: "created#todo", message: "todos.created#Chat room"
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "Todo created" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "Junko Sumii has created a new Todo:'Chat room'"
	
Scenario: List mail, Comment added
Given a mail exists with sender: user "junko", recipient: user "johan", subject: "added#comment", message: "comments.added#Chat room#todo"
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "Comment added" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "Junko Sumii has added a comment to the Todo:'Chat room'"
	
Scenario: List mail, Todo updated
Given a mail exists with sender: user "johan", recipient: user "junko", subject: "updated#todo", message: "todos.updated#Chat room"
	And a user is logged in as "junko"
When I go to the show page of that mail
Then I should see "Todo updated" within "legend"
	And I should see "SenderJohan Sveholm"
	And I should see "RecipientJunko Sumii"
	And I should see "Sent atless than a minute ago"
	And I should see "Johan Sveholm has updated the Todo:'Chat room'"
	
Scenario: List mail, Vote changed
Given a mail exists with sender: user "johan", recipient: user "junko", subject: "changed#vote", message: "votes.changed#Chat room"
	And a user is logged in as "junko"
When I go to the show page of that mail
Then I should see "Vote changed" within "legend"
	And I should see "SenderJohan Sveholm"
	And I should see "RecipientJunko Sumii"
	And I should see "Sent atless than a minute ago"
	And I should see "Johan Sveholm has changed the vote for:'Chat room'"	
	
Scenario: List mail, Comment updated
Given a mail exists with sender: user "johan", recipient: user "junko", subject: "updated#comment", message: "comments.updated#Chat room#todo"
	And a user is logged in as "god"
When I go to the show page of that mail
Then I should see "Comment updated" within "legend"
	And I should see "SenderJohan Sveholm"
	And I should see "RecipientJunko Sumii"
	And I should see "Sent atless than a minute ago"
	And I should see "Johan Sveholm has updated a comment for the Todo:'Chat room'"	

Scenario: List mail, Vote canceled
Given a mail exists with sender: user "johan", recipient: user "junko", subject: "canceled#vote", message: "votes.canceled#Chat room"
	And a user is logged in as "junko"
When I go to the show page of that mail
Then I should see "Vote canceled" within "legend"
	And I should see "SenderJohan Sveholm"
	And I should see "RecipientJunko Sumii"
	And I should see "Sent atless than a minute ago"
	And I should see "Johan Sveholm has canceled the vote for:'Chat room'"

Scenario: List mail, Todo closed
Given a mail exists with sender: user "junko", recipient: user "johan", subject: "closed#todo", message: "todos.closed#Chat room"
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "Todo closed" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "Junko Sumii has closed the Todo:'Chat room'"

Scenario: List mail, Todo re-opened
Given a mail exists with sender: user "junko", recipient: user "johan", subject: "reopened#todo", message: "todos.reopened#Chat room"
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "Todo re-opened" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "Junko Sumii has re-opened the Todo:'Chat room'"

Scenario: Links for god
Given a mail exists with sender: user "junko", recipient: user "reiko", subject: "added#comment", message: "comments.added#Chat room#todo"
	And a user is logged in as "god"
When I go to the show page of that mail
	And I follow "Junko Sumii" within "div#main"
Then I should be redirected to the show page of user: "junko"
When I go to the show page of the mail
	And I follow "Reiko Arikawa"
Then I should be redirected to the show page of user: "reiko"
When I go to the show page of the mail
	And I follow "Junko Sumii has added a comment to the Todo:'Chat room'"
Then I should be redirected to the show page of that todo
When I go to the show page of the mail
	And I follow "Edit" within "div#links"
Then I should be redirected to the edit page of that mail
When I go to the show page of the mail
	And I follow "List Mails" within "div#links"
Then I should be redirected to the mails page
When I go to the show page of the mail
	And I follow "Mailbox" within "div#links"
Then I should be redirected to the box mails page
When I go to the show page of the mail
	And I follow "Del" within "div#links"
Then I should be redirected to the mails page
	And 0 mails should exist
	
Scenario Outline: Links for student&teacher
Given a mail exists with sender: user "johan", recipient: user "<user>", subject: "added#comment", message: "comments.added#Chat room#todo"
	And a user is logged in as "<user>"
When I go to the show page of that mail
	And I should see options "Mailbox" within "div#links"
	And I should not see "Listing Mails" within "div#links"
	And I should not see "Edit" within "div#links"
	And I should not see "Del" within "div#links"
When I follow "Johan Sveholm"
Then I should be redirected to the show page of user: "johan"
When I go to the show page of that mail
	And I follow "<name>"
Then I should be redirected to the show page of user: "<user>"
When I go to the show page of the mail
	And I follow "Johan Sveholm has added a comment to the Todo:'Chat room'"
Then I should be redirected to the show page of that todo
Examples:
|	user		|	name					|
|	prince	|	Prince Philip	|
|	junko		|	Junko Sumii		|

Scenario Outline: Registrants, observers or admins cannot read other peoples email
Given a mail: "johan" exists with sender: user "god", recipient: user "johan", subject: "created#todo", message: "todos.created#Chat room"
	And a mail: "thomas" exists with sender: user "johan", recipient: user "thomas", subject: "updated#todo", message: "todos.updated#Chat room"
	And a mail: "prince" exists with sender: user "thomas", recipient: user "prince", subject: "added#comment", message: "comments.added#Chat room#todo"
	And a mail: "junko" exists with sender: user "prince", recipient: user "junko", subject: "updated#comment", message: "comments.updated#Chat room#todo"
	And a mail: "god" exists with sender: user "junko", recipient: user "god", subject: "updated#comment", message: "comments.updated#Chat room#todo"
	And a user is logged in as "<user>"
When I go to the show page of mail: "god"
Then I <god> be redirected to the show page of mail: "god"
When I go to the show page of mail: "johan"
Then I <johan> be redirected to the show page of mail: "johan"
When I go to the show page of mail: "thomas"
Then I <thomas> be redirected to the show page of mail: "thomas"
When I go to the show page of mail: "prince"
Then I <prince> be redirected to the show page of mail: "prince"
When I go to the show page of mail: "junko"
Then I <junko> be redirected to the show page of mail: "junko"
Examples:
|	user 		|	god					|	johan				|	thomas			|	prince			|	junko				|
|	god			|	should			|	should			|	should			|	should			|	should			|
|	johan		|	should not	|	should 			|	should not	|	should not	|	should not	|
|	thomas	|	should not	|	should not	|	should    	|	should not	|	should not	|
|	prince	|	should not	|	should not	|	should not  |	should			|	should not	|
|	junko		|	should not	|	should not	|	should not  |	should not	|	should			|