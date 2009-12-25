Background:
Given a setting exists with name: "main"
	And a user: "aya" exists with username: "aya", role: "admin", language: "en"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant", language: "ja"

Scenario: Display the event list
Given a user is logged in as "kurosawa"
	And a event exist with title_en: "Christmas Party", title_ja: "クリスマスパーティ", date: "2009-12-19", description_en: "It's Christmas!", description_ja: "クリスマスタイム！"
When I go to the events page
Then I should see events table
  |	イベント名					|	開催日			|	記述					|
  |	クリスマスパーティ	|	2009-12-19	|	クリスマスタイム！	|	
When I follow 'edit_profile'
	And I select "英語" from 'language'
	And I press 'update'
Then I should see events table
  |	Event						|	Date				|	Description			|
  |	Christmas Party	|	2009-12-19	|	It's Christmas!	|

Scenario: Create an event
Given a user is logged in as "aya"
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
  And a gallery should exist with event: that event
	And I should be redirected to the events page

Scenario: When an event is deleted, its gallery, registrants & comments should be deleted
Given a user is logged in as "aya"
	And a event exist with title_en: "Christmas Party!"
	And a comment exists with event: that event, user: user "aya", comment: "comment 1"
	And a comment exists with event: that event, user: user "kurosawa", comment: "comment 2"
	And a registrant exists with event: that event, user: user "kurosawa"
Then a gallery should exist with event: that event
	And 1 galleries should exist
	And 2 comments should exist
	And 1 registrants should exist
When I go to the events page
  And I follow 'delete'
Then 0 events should exist
  And 0 galleries should exist 
  And 0 comments should exist
  And 0 registrants should exist

#Scenario: When an event is deleted, its registrants and comments should be deleted
#Given not implemented

#Make title_ja, description_ja in database
#Registrants keep building up...