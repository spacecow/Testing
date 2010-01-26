@delete
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant, student", language: "ja", name: "Akira Kurosawa"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"

Scenario: Delete a mail
Given a mail exists with sender: user "johan", subject: "registered#user", message: "users.registered#Mafumafu##"
	And a recipient exists with user: user "junko", mail: that mail
	And a recipient exists with user: user "thomas", mail: that mail
	And a user is logged in as "johan"
Then 1 mails should exist
	And 2 recipients should exist
When I go to the show page of that mail
	And I follow "Del" within "div#links"
Then I should be redirected to the mails page
	And I should see "Successfully deleted mail"
	And 0 mails should exist
	And 0 recipients should exist