Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user is logged in as "johan"
	And a event exist with title_en: "Christmas Party", date: "2009-12-19"

Scenario: Create an image
When I go to the galleries page
Then show me the page
  And I follow 'show'
Then I should see 'photos.add'
