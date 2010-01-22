@show
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "admin, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "reiko" exists with username: "reiko", role: "registrant, student", language: "en", name: "Reiko Arikawa"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "god" exists with username: "god", role: "god, teacher", language: "en", name: "God Almighty"
	And a todo exists with subjects_mask: 1, title: "Chat room"

@registration_mail
Scenario: List a registration mail
Given a mail exists with sender: user "johan", subject: "registered#user", message: "users.registered#Mafumafu##"
	And a recipient exists with user: user "junko", mail: that mail
	And a user is logged in as "junko"
When I go to the show page of that mail
Then I should see "User registered" within "legend"
	And I should see "SenderJohan Sveholm"
	And I should see "RecipientJunko Sumii"
	And I should see "Sent atless than a minute ago"
	And I should see "MessageWelcome to Mafumafu's Reservation System!"

@regular_mail
Scenario: List an empty mail
Given a mail exists with sender: user "johan", subject: "no_subject", message: ""
	And a recipient exists with user: user "thomas", mail: that mail
	And a user is logged in as "thomas"
When I go to the show page of that mail
Then I should see "<no subject>" within "legend"
	And I should not see "en, <no subject>" within "legend"
	And I should see "SenderJohan Sveholm"
	And I should see "RecipientThomas Osburg"
	And I should see "Sent atless than a minute ago"
	
Scenario: List a regular mail
Given a mail exists with sender: user "junko", subject: "A boring subject", message: "A boring message"
	And a recipient exists with user: user "johan", mail: that mail	
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "A boring subject" within "legend"
	And I should not see "en, A boring subject" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "MessageA boring message"
	And I should not see "en, A boring message"

Scenario: List mail, Vote created
Given a mail exists with sender: user "junko", subject: "created#vote", message: "votes.created#Chat room##"
	And a recipient exists with user: user "johan", mail: that mail
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "Vote created" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "MessageJunko Sumii has voted for:'Chat room'"

Scenario: List mail, Todo created
Given a mail exists with sender: user "junko", subject: "created#todo", message: "todos.created#Chat room##"
	And a recipient exists with user: user "johan", mail: that mail
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "Todo created" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "MessageJunko Sumii has created a new Todo:'Chat room'"
	
Scenario: List mail, Comment added
Given a mail exists with sender: user "junko", subject: "added#comment", message: "comments.added#Chat room#todo#Awesome comment!"
	And a recipient exists with user: user "johan", mail: that mail
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "Comment added" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "MessageJunko Sumii has added a comment to the Todo:'Chat room'"
	And I should see "Awesome comment!"
	
Scenario: List mail, Todo updated
Given a mail exists with sender: user "johan", subject: "updated#todo", message: "todos.updated#Chat room##"
	And a recipient exists with user: user "junko", mail: that mail
	And a user is logged in as "junko"
When I go to the show page of that mail
Then I should see "Todo updated" within "legend"
	And I should see "SenderJohan Sveholm"
	And I should see "RecipientJunko Sumii"
	And I should see "Sent atless than a minute ago"
	And I should see "MessageJohan Sveholm has updated the Todo:'Chat room'"
	
Scenario: List mail, Vote changed
Given a mail exists with sender: user "johan", subject: "changed#vote", message: "votes.changed#Chat room##"
	And a recipient exists with user: user "junko", mail: that mail
	And a user is logged in as "junko"
When I go to the show page of that mail
Then I should see "Vote changed" within "legend"
	And I should see "SenderJohan Sveholm"
	And I should see "RecipientJunko Sumii"
	And I should see "Sent atless than a minute ago"
	And I should see "MessageJohan Sveholm has changed the vote for:'Chat room'"	
	
Scenario: List mail, Comment updated
Given a mail exists with sender: user "johan", subject: "updated#comment", message: "comments.updated#Chat room#todo#Awesomer comment!"
	And a recipient exists with user: user "junko", mail: that mail
	And a user is logged in as "god"
When I go to the show page of that mail
Then I should see "Comment updated" within "legend"
	And I should see "SenderJohan Sveholm"
	And I should see "RecipientJunko Sumii"
	And I should see "Sent atless than a minute ago"
	And I should see "MessageJohan Sveholm has updated a comment for the Todo:'Chat room'"	
	And I should see "Awesomer comment!"

Scenario: List mail, Vote canceled
Given a mail exists with sender: user "johan", subject: "canceled#vote", message: "votes.canceled#Chat room##"
	And a recipient exists with user: user "junko", mail: that mail
	And a user is logged in as "junko"
When I go to the show page of that mail
Then I should see "Vote canceled" within "legend"
	And I should see "SenderJohan Sveholm"
	And I should see "RecipientJunko Sumii"
	And I should see "Sent atless than a minute ago"
	And I should see "MessageJohan Sveholm has canceled the vote for:'Chat room'"

Scenario: List mail, Todo closed
Given a mail exists with sender: user "junko", subject: "closed#todo", message: "todos.closed#Chat room##"
	And a recipient exists with user: user "johan", mail: that mail
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "Todo closed" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "MessageJunko Sumii has closed the Todo:'Chat room'"

Scenario: List mail, Todo re-opened
Given a mail exists with sender: user "junko", subject: "reopened#todo", message: "todos.reopened#Chat room##"
	And a recipient exists with user: user "johan", mail: that mail
	And a user is logged in as "johan"
When I go to the show page of that mail
Then I should see "Todo re-opened" within "legend"
	And I should see "SenderJunko Sumii"
	And I should see "RecipientJohan Sveholm"
	And I should see "Sent atless than a minute ago"
	And I should see "MessageJunko Sumii has re-opened the Todo:'Chat room'"

@god
Scenario: Links for god
Given a mail exists with sender: user "junko", subject: "added#comment", message: "comments.added#Chat room#todo#Fuck Christmas!"
	And a recipient exists with user: user "reiko", mail: that mail
	And a recipient exists with user: user "thomas", mail: that mail
	And a user is logged in as "god"
When I go to the show page of that mail
	And I follow "Junko Sumii" within "div.pairs"
Then I should be redirected to the show page of user: "junko"
When I go to the show page of the mail
	And I follow "Reiko Arikawa" within "div.pairs"
Then I should be redirected to the show page of user: "reiko"
When I go to the show page of the mail
	And I follow "Thomas Osburg" within "div.pairs"
Then I should be redirected to the show page of user: "thomas"
When I go to the show page of the mail
	And I follow "Junko Sumii has added a comment to the Todo:'Chat room'" within "div.pairs"
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
Given a mail exists with sender: user "johan", subject: "added#comment", message: "comments.added#Chat room#todo"
	And a recipient exists with user: user "<user>", mail: that mail
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
Given a mail: "johan" exists with sender: user "god", subject: "created#todo", message: "todos.created#Chat room"
	And a recipient exists with user: user "johan", mail: that mail
	And a mail: "thomas" exists with sender: user "johan", subject: "updated#todo", message: "todos.updated#Chat room"
	And a recipient exists with user: user "thomas", mail: that mail
	And a mail: "prince" exists with sender: user "thomas", subject: "added#comment", message: "comments.added#Chat room#todo"
	And a recipient exists with user: user "prince", mail: that mail
	And a mail: "junko" exists with sender: user "prince", subject: "updated#comment", message: "comments.updated#Chat room#todo"
	And a recipient exists with user: user "junko", mail: that mail
	And a mail: "god" exists with sender: user "junko", subject: "updated#comment", message: "comments.updated#Chat room#todo"
	And a recipient exists with user: user "god", mail: that mail
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