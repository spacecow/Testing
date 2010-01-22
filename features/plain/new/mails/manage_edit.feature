@edit
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"

Scenario: Links on edit page (for super users)
Given a mail exists with sender: user "junko", subject: "A boring subject", message: "A boring message"
	And a recipient exists with user: user "aya", mail: that mail
	And a user is logged in as "johan"
When I go to the edit page of that mail
Then I should see options "Info, Mailbox, List Mails, Del" within "div#links"
When I follow "Info" within "div#links"
Then I should be redirected to the show page of that mail
When I go to the edit page of that mail
	And I follow "Mailbox" within "div#links"
Then I should be redirected to the box mails page
When I go to the edit page of that mail
	And I follow "List Mails" within "div#links"
Then I should be redirected to the mails page
When I go to the edit page of that mail
	And I follow "Del" within "div#links"
Then I should be redirected to the mails page
	And 0 mails should exist

@edit_mail
Scenario: Edit a mail
Given a mail exists with sender: user "junko", subject: "A boring subject", message: "A boring message"
	And a recipient exists with user: user "aya", mail: that mail	
	And a user is logged in as "johan"
When I go to the edit page of that mail
Then I should see "Editing Mail" within "legend" 
	And the "Aya Komatsu" checkbox should be checked
	And "Junko Sumii" should be selected in the "Sender" field
	And the "Sender" field should have options "BLANK, Johan Sveholm, Junko Sumii, Thomas Osburg, Aya Komatsu"
When I uncheck "Aya Komatsu"
	And I select "" from "Sender"
	And I press "Update"
Then I should be redirected to the error show page of that mail
	And I should see "Recipient* Johan Sveholm Junko Sumii Thomas Osburg Aya Komatsucan't be blank"
	And I should see "Sender*Johan SveholmJunko SumiiThomas OsburgAya Komatsucan't be blank"
	And I check "Johan Sveholm"
	And I select "Thomas Osburg" from "Sender"
	And I fill in "Subject" with ""
	And I fill in "Message" with "An even more boring message"
	And I press "Update"
Then I should be redirected to the show page of that mail
	And I should see "Successfully updated mail." within "div#notice"
	And 1 mails should exist
	And a mail should exist with sender: user "thomas", subject: "no_subject", message: "An even more boring message"
	And 1 recipients should exist
	And a recipient should exist with user: user "johan", mail: that mail

@edit_staket
Scenario: Subjects or messages cannot contain #
Given a mail exists with sender: user "junko", subject: "A boring subject", message: "A boring message"
	And a recipient exists with user: user "aya", mail: that mail
	And a user is logged in as "johan"
When I go to the edit page of that mail
	And I fill in "Subject" with "one#more#subject"
	And I fill in "Message" with "a#message"
	And I press "Update"
Then 1 mails should exist
	And a mail should exist with sender: user "junko", subject: "one*more*subject", message: "a*message"
	And 1 recipients should exist
	And a recipient should exist with user: user "aya", mail: that mail

Scenario Outline: Try to edit a mail without permission
Given a mail exists with sender: user "junko", subject: "A boring subject", message: "A boring message"
	And a recipient exists with user: user "aya", mail: that mail
	And a user is logged in as "<user>"
When I go to the edit page of that mail
Then I should be redirected to the events page
Examples:
|	user		|
|	junko		|
|	thomas	|
|	aya			|