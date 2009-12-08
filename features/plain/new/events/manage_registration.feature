@event_registration
Background:
Given a setting exists with name: "main"

Scenario: Register a user to an event
Given a user: "kurosawa" exists with username: "kurosawa_akira", role: "registrant", language: "en"
	And a user is logged in as "kurosawa_akira"
	And an event: "christmas" exists with title_en: "Christmas Party"
When I go to the events page
	And I follow 'show'
	And I press 'register'
Then the 'email' field should contain "fake@fake.com"
When I select "Exchange Student" from 'occupation'
	And I select "10's" from 'age'
	And I fill in 'tel' with "080-1234-5678"
	And I press 'register'
Then I should see 'successfully'
	Then a registrant should exist with event: event "christmas", user: user "kurosawa"
	And a user should exist with occupation: "Exchange Student", age: "10", tel: "080-1234-5678"

Scenario: One cannot register to events without a user
Given an event exists with title_ja: "クリスマスパーティ"
When I go to the show page for that event
Then I should see 'events.message.please_login'
