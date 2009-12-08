Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user is logged in as "johan"
	And a event exist with title_en: "Christmas Party", date: "2009-12-19"

Scenario: Create an image
When I go to the galleries page
  And I follow 'show'
  And I follow 'photos.add'
  And I press 'add'
Then I should see "Photo file name can't be blank"
When I attach the file at "C:/Pictures/_F2A5552.JPG" to "Photo*"
  And I press 'add'
  