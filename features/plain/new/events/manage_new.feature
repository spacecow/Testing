@new
Background:
Given a setting exists with name: "main"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en"

Scenario: Create an event
Given a user is logged in as "aya"
When I go to the events page
	And I follow "New Event" within "div.links"
	And I fill in "Title (en)*" with "Christmas Party"
	And I select "2009, December, 19, 19, 00" from dropmenus "event_start_date"
	And I select "2009, December, 19, 21, 00" from dropmenus "event_end_date"
	And I select "2009, December, 10, 23, 59" from dropmenus "event_due_date"
	And I fill in "Description (en)" with "It's Christmas!"
	And I press "Create"
Then I should be redirected to the error events page
When I fill in "Title (ja)*" with "クリスマスパーティ"
	And I press "Create"
Then a event should exist with title_en: "Christmas Party", title_ja: "クリスマスパーティ", description_en: "It's Christmas!", end_date: "2009-12-19 21:00:00", due_date: "2009-12-10 23:59:00", start_date: "2009-12-19 19:00:00"
  And a gallery should exist with event: that event
	And I should be redirected to the events page