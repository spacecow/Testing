Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user exists with username: "thomas", role: "observer", language: "en"
	And a user exists with username: "kurosawa", role: "registrant", language: "ja"
	And a user: "junko" exists with username: "junko", role: "registrant", language: "en"

Scenario: Create new Todo
Given a user is logged in as "junko"
When I go to the new todo page
  And I fill in "Title" with "Chat room"
  And I fill in "Description" with "Wouldn't that be fun!"
  And I check "Bug"
  And I press "Create"
Then I should be redirected to the todos page
  And I should see "Successfully created Todo."
  And a todo should exist with subjects_mask: 1, user: user "junko", title: "Chat room", description: "Wouldn't that be fun!"  