@manage_new
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"

@new_links
Scenario Outline: Links on the new page for other than super users
Given a user is logged in as "<user>"
When I go to the new mail page
Then I should see "Mailbox" within "div.links"
When I follow "Mailbox" within "div.links"
Then I should be redirected to the box mails page
Examples:
|	user		|	links		|
|	junko		| Mailbox	|
|	thomas	| Mailbox	|
|	aya			| Mailbox	|

Scenario: Links on the new page for super users
Given a user is logged in as "johan"
When I go to the new mail page
Then I should see options "Mailbox, List Mails" within "div.links"
When I follow "Mailbox" within "div.links"
Then I should be redirected to the box mails page
When I go to the new mail page
When I follow "List Mails" within "div.links"
Then I should be redirected to the mails page

@new_mail
Scenario: Create a new mail
Given a user is logged in as "junko"
When I go to the new mail page
Then the "Recipient" field should have options "BLANK, Johan Sveholm, Thomas Osburg, Aya Komatsu"
When I press "Send"
Then I should be redirected to the error mails page
	And the "Recipient" field should have options "BLANK, Johan Sveholm, Thomas Osburg, Aya Komatsu"
	And I should see "Recipient*Johan SveholmThomas OsburgAya Komatsucan't be blank"
	And I should not see "Sender can't be blank"
When I select "Aya Komatsu" from "Recipient"
	And I fill in "Subject" with "A boring subject"
	And I fill in "Message" with "A boring message"
	And I press "Send"
Then I should be redirected to the box mails page
	And I should see "Successfully sent mail." within "div#notice"
	And a mail should exist with recipient: user "aya", sender: user "junko", subject: "A boring subject", message: "A boring message"

Scenario: Fill in subject if it is left blank
Given a user is logged in as "junko"
When I go to the new mail page
	And I select "Thomas Osburg" from "Recipient"
	And I press "Send"
Then I should be redirected to the box mails page
	And I should see "Successfully sent mail." within "div#notice"
	And a mail should exist with recipient: user "thomas", sender: user "junko", subject: "no_subject", message: ""
