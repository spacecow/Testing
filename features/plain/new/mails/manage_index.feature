@manage_index
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user is logged in as "johan"

Scenario: List Mails
Given a mail exists with sender: user "junko", recipient: user "johan", subject: "created#todo"
Given a mail exists with sender: user "johan", recipient: user "junko", subject: "updated#todo"
Given a mail exists with sender: user "junko", recipient: user "thomas", subject: "added#comment"
Given a mail exists with sender: user "thomas", recipient: user "johan", subject: "updated#comment"
When I go to the mails page
Then I should see "Listing Mail" within "h1"
And I should see "mails" table
|	Recipient 		|	Sender				|	Subject					|	Sent at									|
|	Johan Sveholm	|	Thomas Osburg	|	Comment updated	|	less than a minute ago	|
|	Thomas Osburg	|	Junko Sumii		|	Comment added		|	less than a minute ago	|
|	Junko Sumii		|	Johan Sveholm	|	Todo updated		|	less than a minute ago	|
|	Johan Sveholm	|	Junko Sumii		|	Todo created		|	less than a minute ago	|

Scenario: Links
Given a mail exists with sender: user "johan", recipient: user "johan", subject: "created#todo", message: "created#Chat room"
When I go to the mails page
	And I follow "Junko Sumii"
Then I should be redirected to the show page of user: "junko"
When I go to the mails page
	And I follow "Johan Sveholm"
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