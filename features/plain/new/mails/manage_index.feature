@index
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"

@list_mails
Scenario: List Mails
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
	And a recipient exists with user: user "thomas", mail: mail "nosubject"
	And a recipient exists with user: user "junko", mail: mail "nosubject"
	And a mail: "registeruser" exists with sender: user "johan", subject: "registered#user"
	And a recipient exists with user: user "junko", mail: mail "registeruser"
	And a user is logged in as "johan"
When I go to the mails page
Then I should see "Listing Mail" within "h1"
And I should see "mails" table
|	Recipient 										|	Sender				|	Subject							|	Sent at									|
|	Junko Sumii										|	Johan Sveholm	|	User registered			|	less than a minute ago	|
|	Junko Sumii, Thomas Osburg		|	Johan Sveholm	|	<no subject>				|	less than a minute ago	|
|	Junko Sumii										|	Johan Sveholm	|	A boring subject		|	less than a minute ago	|
|	Junko Sumii										|	Johan Sveholm	|	Todo re-opened			|	less than a minute ago	|
|	Johan Sveholm									|	Junko Sumii		|	Todo closed					|	less than a minute ago	|
|	Johan Sveholm									|	Thomas Osburg	|	Vote canceled				|	less than a minute ago	|
|	Thomas Osburg									|	Junko Sumii		|	Vote created				|	less than a minute ago	|
|	Junko Sumii										|	Johan Sveholm	|	Vote changed				|	less than a minute ago	|
|	Johan Sveholm									|	Thomas Osburg	|	Comment updated			|	less than a minute ago	|
|	Thomas Osburg									|	Junko Sumii		|	Comment added				|	less than a minute ago	|
|	Junko Sumii										|	Johan Sveholm	|	Todo updated				|	less than a minute ago	|
|	Johan Sveholm									|	Junko Sumii		|	Todo created				|	less than a minute ago	|

Scenario: Links
Given a mail exists with sender: user "johan", subject: "created#todo", message: "created#Chat room"
	And a recipient exists with user: user "junko", mail: that mail
	And a recipient exists with user: user "thomas", mail: that mail
	And a user is logged in as "johan"
Then 1 mails should exist
When I go to the mails page
	And I follow "Junko Sumii" within "div#list table"
Then I should be redirected to the show page of user: "junko"
When I go to the mails page
	And I follow "Thomas Osburg" within "div#list table"
Then I should be redirected to the show page of user: "thomas"
When I go to the mails page
	And I follow "Johan Sveholm" within "div#list table"
Then I should be redirected to the show page of user: "johan"
When I go to the mails page
	And I follow "Info" within "table tr td#links"
Then I should be redirected to the show page of that mail
When I go to the mails page
	And I follow "Edit" within "table tr td#links"
Then I should be redirected to the edit page of that mail
When I go to the mails page
	And I follow "Del" within "table tr td#links"
Then I should be redirected to the mails page
	And 0 mails should exist
When I go to the mails page
	And I follow "New Mail" within "div#links"
Then I should be redirected to the new mail page

Scenario: Johan should see all recipients on the show page (NOT IMPLEMENTED)
Given not implemented