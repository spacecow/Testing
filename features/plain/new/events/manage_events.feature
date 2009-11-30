@events
Scenario: Create an event
Given a user exists with username: "aya", role: "admin", language: "en"
	And a user is logged in as "aya"
When I go to the events page
	And I follow 'events.new'
	And I fill in "Title (en)*" with "Christmas Party"
	And I fill in 'event_date' with "2009-12-19"
	And I fill in 'description_en' with "It's Christmas!"
	And I press 'create'
Then I should be redirected to the error events page
When I fill in "Title (ja)*" with "クリスマスパーティ"
	And I press 'create'
Then a event should exist with title_en: "Christmas Party", title_ja: "クリスマスパーティ", date: "2009-12-19", description_en: "It's Christmas!"
	And I should be redirected to the events page

Scenario: Display the event list
Given a event exist with title_en: "Christmas Party", title_ja: "クリスマスパーティ", date: "2009-12-19", description_en: "It's Christmas!", description_ja: "クリスマスタイム！"
When I go to the events page
Then I should see events table
  |	タイトル				|	日付					|	記述					|
  |	クリスマスパーティ	|	2009-12-19	|	クリスマスタイム！	|	
When I follow "English"
Then I should see events table
  |	Title						|	Date				|	Description			|
  |	Christmas Party	|	2009-12-19	|	It's Christmas!	|

Scenario: Display a single event
Given a event exist with title_en: "Christmas Party!", title_ja: "クリスマスパーティ", date: "2009-12-19", description_en: "It's Christmas!", description_ja: "クリスマスタイム！"
When I go to the show page for that event
Then I should see "クリスマスパーティ - 2009-12-19" within "legend"
	And I should see "クリスマスタイム！"
	And I should see 'registrants.title'": 0"	
When I follow "English"
Then I should see "Christmas Party! - 2009-12-19" within "legend"
	And I should see "It's Christmas!"

#Make title_ja, description_ja in database
#Registrants keep building up...