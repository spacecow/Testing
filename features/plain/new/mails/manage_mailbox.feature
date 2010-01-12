@mailbox
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "thomas" exists with username: "thomas", role: "registrant, student", language: "en", name: "Thomas Osburg"

Scenario: List mails in mailbox
Given a user is logged in as "johan"
	And a mail exists with sender: user "junko", recipient: user "johan", subject: "created#todo"
	And a mail exists with sender: user "johan", recipient: user "junko", subject: "updated#todo"
	And a mail exists with sender: user "junko", recipient: user "thomas", subject: "added#comment"
	And a mail exists with sender: user "thomas", recipient: user "johan", subject: "updated#comment"
When I go to the box mails page
Then I should see "Mailbox" within "h1"
And I should see "mails" table
|	Sender				|	Subject					|	Sent at									|
|	Thomas Osburg	|	Comment updated	|	less than a minute ago	|
|	Junko Sumii		|	Todo created		|	less than a minute ago	|

Scenario: Links
Given a user is logged in as "johan"
	And a mail: "todo" exists with sender: user "junko", recipient: user "johan", subject: "created#todo", message: "todos.created#Chat room"
	And a mail: "comment" exists with sender: user "thomas", recipient: user "johan", subject: "updated#comment", message: "comments.updated#Chat room#todo"
Then 0 mails should exist with read: true
	And 2 mails should exist with read: false
When I go to the box mails page
	And I follow "Junko Sumii"
Then I should be redirected to the show page of user: "junko" 
When I go to the box mails page
	And I follow "Thomas Osburg"
Then I should be redirected to the show page of user: "thomas" 
When I go to the box mails page
	And I follow "Comment updated"
Then I should be redirected to the show page of mail: "comment"
	And a mail should exist with subject: "updated#comment", read: true
	And a mail should exist with subject: "created#todo", read: false
When I go to the box mails page
	And I follow "Todo created"
Then I should be redirected to the show page of mail: "todo"
	And a mail should exist with subject: "updated#comment", read: true
	And a mail should exist with subject: "created#todo", read: true
	And 2 mails should exist with read: true
	
Scenario: Create one's own mail and send them to a user on the site (NOT IMPLEMENTED)
Given not implemented

Scenario: Automatic mail when someone votes (NOT IMPLEMENTED)
Given not implemented

Scenario: Automatic mail to all affected when a todo is closed/reopened (NOT IMPLEMENTED)
Given not implemented

Scenario: Automatic mail when a event comment is written (NOT IMPLEMENTED)
Given not implemented

Scenario: Automatic mail when a photo is uploaded (NOT IMPLEMENTED)
Given not implemented