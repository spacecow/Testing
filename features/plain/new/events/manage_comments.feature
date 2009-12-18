@event_comments
Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant", language: "en"
	And a event: "christmas" exist with title_en: "Christmas Party!"
	And a comment: "fuck" exists with comment: "Fuck Christmas!", event: event "christmas", user: user "kurosawa"

Scenario: Move comment and create a new Todo
Given a user is logged in as "johan"
When I go to the show page of that event
	And I follow "move" within comment "fuck"
Then I should be redirected to the new todo page
	And the "Description" field should contain "Fuck Christmas!"
When I fill in "Title" with "Christmas Spirit"
	And I check "Bug"
	And I press "Create"
	Then show me the page
Then I should be redirected to the show page of event "christmas"
	And a todo should exist with title: "Christmas Spirit", description: "Fuck Christmas!", subjects_mask: 1, user: user "kurosawa"
	And 0 comments should exist
	
Scenario: Move comment and create a new Todo
Given a user is logged in as "johan"
When I go to the show page of that event
	And I follow "move" within comment "fuck"
Then I should be redirected to the new todo page
When I go to the show page of event "christmas"
Then I should see "Fuck Christmas!" within comment "fuck"
	And 0 todos should exist	

