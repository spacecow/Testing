@events
Scenario: Create an event
Given a user exists with username: "aya", role: "admin"
	And a user is logged in as "aya"
When I go to the events page
	And I follow 'events.new'
	And I fill in 'title' with "Christmas"
	And I fill in 'event_date' with "2009-12-19"
	And I fill in 'description' with "It's Christmas!"
	And I press 'create'
Then a event should exist with title: "Christmas", date: "2009-12-19", description: "It's Christmas!"
	And I should be redirected to the events page
  And I should see events table
  |	Title			|	Date				|	Description			|
  |	Christmas	|	2009-12-19	|	It's Christmas!	|
When I go to the show page for that event
Then I should see "Christmas - 2009-12-19" within "legend"
	And I should see 'registrants.title'": 0"	

#Make title_ja, description_ja in database
#Registrants keep building up...