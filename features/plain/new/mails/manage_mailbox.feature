@mailbox
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "thomas" exists with username: "thomas", role: "registrant, student", language: "en", name: "Thomas Osburg"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"

@mailbox_list
Scenario: List mails in mailbox
Given a mail: "createtodo" exists with sender: user "junko", subject: "created#todo"
	And a recipient exists with user: user "johan", mail: mail "createtodo"
	And a mail: "updatetodo" exists with sender: user "johan", subject: "updated#todo"
	And a recipient exists with user: user "junko", mail: mail "updatetodo"
	And a mail: "addcomment" exists with sender: user "junko", subject: "added#comment"
	And a recipient exists with user: user "thomas", mail: mail "addcomment"
	And a mail: "updatecomment" exists with sender: user "thomas", subject: "updated#comment"
	And a recipient exists with user: user "johan", mail: mail "updatecomment"
	And a mail: "changevote" exists with sender: user "johan", subject: "changed#vote"
	And a recipient exists with user: user "junko", mail: mail "changevote"
	And a mail: "createvote" exists with sender: user "junko", subject: "created#vote"
	And a recipient exists with user: user "thomas", mail: mail "createvote"
	And a mail: "cancelvote" exists with sender: user "thomas", subject: "canceled#vote"
	And a recipient exists with user: user "johan", mail: mail "cancelvote"
	And a mail: "closetodo" exists with sender: user "junko", subject: "closed#todo"
	And a recipient exists with user: user "johan", mail: mail "closetodo"
	And a mail: "reopentodo" exists with sender: user "johan", subject: "reopened#todo"
	And a recipient exists with user: user "junko", mail: mail "reopentodo"
	And a mail: "subject" exists with sender: user "johan", subject: "A boring subject"
	And a recipient exists with user: user "junko", mail: mail "subject"
	And a mail: "nosubject" exists with sender: user "johan", subject: "no_subject"
	And a recipient exists with user: user "junko", mail: mail "nosubject"
	And a user is logged in as "junko"
When I go to the box mails page
Then I should see "Mailbox" within "h1"
And I should see "mails" table
|	Sender				|	Subject							|	Sent at									|
|	Johan Sveholm	|	&lt;no subject&gt;	|	less than a minute ago	|
|	Johan Sveholm	|	A boring subject		|	less than a minute ago	|
|	Johan Sveholm	|	Todo re-opened			|	less than a minute ago	|
|	Johan Sveholm	|	Vote changed				|	less than a minute ago	|
|	Johan Sveholm	|	Todo updated				|	less than a minute ago	|

@unread_mails
Scenario: Links and mark mails as read
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
When I go to the box mails page
Then I should see options "New Mail, List Mails" within "div#links"
When I follow "New Mail" within "div#links"
Then I should be redirected to the new mail page
When I go to the box mails page
	And I follow "List Mails" within "div#links"
Then I should be redirected to the mails page

Scenario Outline: Bottom links
Given a user is logged in as "<user>"
When I go to the box mails page
Then I should see options "New Mail" within "div#links"
When I follow "New Mail" within "div#links"
Then I should be redirected to the new mail page
Examples:
|	user		|
|	junko		|
|	thomas	|
|	aya			|
	
Scenario: Automatic mail when a event comment is written (NOT IMPLEMENTED)
Given not implemented

Scenario: Automatic mail when a photo is uploaded (NOT IMPLEMENTED)
Given not implemented

Scenario: Check more than one mailbox with multiple recipients (NOT IMPLEMENTED)
Given not implemented