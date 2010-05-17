@new
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"

@new_mail
Scenario: Create a new mail
Given a user is logged in as "junko"
When I go to the new mail page
Then I should see "New Mail" within "legend"
	And 4 users should exist
	And I should see "Johan Sveholm" within "li.check_boxes"
	And I should see "Junko Sumii" within "li.check_boxes"
	And I should see "Thomas Osburg" within "li.check_boxes"
	And I should see "Aya Komatsu" within "li.check_boxes"
When I press "Send"
Then I should be redirected to the error mails page
	And I should see "Johan Sveholm" within "li.check_boxes"
	And I should see "Junko Sumii" within "li.check_boxes"
	And I should see "Thomas Osburg" within "li.check_boxes"
	And I should see "Aya Komatsu" within "li.check_boxes"	
	And I should see "Recipient* Johan Sveholm Junko Sumii Thomas Osburg Aya Komatsucan't be blank"
	And I should not see "Sender can't be blank"
When I check "Aya Komatsu"
	And I check "Thomas Osburg"
	And I fill in "Subject" with "A boring subject"
	And I fill in "Message" with "A boring message"
	And I press "Send"
Then I should be redirected to the box mails page
	And I should see "Successfully sent mail." within "div#notice"
	And 1 mails should exist
	And a mail should exist with sender: user "junko", subject: "A boring subject", message: "A boring message"
	And 2 recipients should exist
	And a recipient should exist with user: user "aya", mail: that mail
	And a recipient should exist with user: user "thomas", mail: that mail

Scenario: Subject should be automatically filled in if it is left blank
Given a user is logged in as "junko"
When I go to the new mail page
	And I check "Thomas Osburg"
	And I press "Send"
Then I should be redirected to the box mails page
	And I should see "Successfully sent mail." within "div#notice"
	And 1 mails should exist
	And a mail should exist with sender: user "junko", subject: "no_subject", message: ""
	And 1 recipients should exist
	And a recipient should exist with user: user "thomas", mail: that mail

@staket
Scenario: Subjects or messages cannot contain #
Given a user is logged in as "junko"
When I go to the new mail page
	And I check "Thomas Osburg"
	And I fill in "Subject" with "one#more#subject"
	And I fill in "Message" with "a#message"
	And I press "Send"
Then 1 mails should exist
	And a mail should exist with sender: user "junko", subject: "one*more*subject", message: "a*message"
	And 1 recipients should exist
	And a recipient should exist with user: user "thomas", mail: that mail


Scenario Outline: Links on the new page for other than super users
Given a user is logged in as "<user>"
When I go to the new mail page
Then I should see "Mailbox" within "div#links"
When I follow "Mailbox" within "div#links"
Then I should be redirected to the box mails page
Examples:
|	user		|	links		|
|	junko		| Mailbox	|
|	thomas	| Mailbox	|
|	aya			| Mailbox	|

Scenario: Links on the new page for super users
Given a user is logged in as "johan"
When I go to the new mail page
Then I should see options "Mailbox, List Mails" within "div#links"
When I follow "Mailbox" within "div#links"
Then I should be redirected to the box mails page
When I go to the new mail page
When I follow "List Mails" within "div#links"
Then I should be redirected to the mails page

@pending
Scenario: When the number of users increases, check_boxes are no longer an option - nested form? (NOT IMPLEMENTED)
