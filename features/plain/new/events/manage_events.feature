Background:
Given a setting exists with name: "main"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant", language: "ja"

Scenario: Display the event list in English and Japanese
Given a user is logged in as "kurosawa"
	And an event exist with title_en: "Christmas Party", title_ja: "クリスマスパーティ", start_date: "2009-12-19 19:00", end_date: "2009-12-19 21:00", description_en: "It's Christmas!", description_ja: "クリスマスタイム！", place: "141", cost: "2500円, non Japanese free"
When I go to the events page
Then I should see events table
  |	イベント名					|	日時										|	場所	|	会費											|
  |	クリスマスパーティ	|	2009-12/19 19:00 - 21:00	|	141				|	2500円, non Japanese free	|	
When I follow 'edit_profile'
	And I select "英語" from "このサイトはどんな言語で利用する？*"
	And I press 'update'
Then I should see events table
  |	Event						|	Date&amp;Time											|	Place	|	Cost											|
  |	Christmas Party	|	2009-12/19 19:00 - 21:00	|	141		|	2500円, non Japanese free	|

@list_events
Scenario: Display the list in order
Given an event exists with title_en: "Year-end Party", start_date: "2009-12-23 07:00", end_date: "2009-12-24 13:00", place: "Aizu", cost: "free"
	And an event exists with title_en: "Christmas Party", start_date: "2009-12-19 19:00", end_date: "2009-12-19 21:00", place: "141", cost: "2500円, non Japanese free"
	And an event exists with title_en: "Talking Party", start_date: "2010-01-09 18:00", end_date: "2010-01-09 20:00", place: "AER 28th floor", cost: "1500円, non Japanese free"
	And an event exists with title_en: "New Year Party", start_date: "2009-12-31 20:00", end_date: "2010-01-01 05:00", place: "Bar Isn't It", cost: "2500円"
	And a user is logged in as "aya"
When I go to the events page
Then I should see events table
|	Event						|	Date&amp;Time												|	Place						|	Cost											|
|	Talking Party		|	01/09 18:00 - 20:00									|	AER 28th floor	|	1500円, non Japanese free	|
|	New Year Party	|	2009-12/31 20:00 - 2010-01/01 05:00	|	Bar Isn't It		|	2500円										|
|	Year-end Party	|	2009-12/23 07:00 - 12/24 13:00			|	Aizu						|	free											|
|	Christmas Party	|	2009-12/19 19:00 - 21:00						|	141							|	2500円, non Japanese free	|

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

Scenario: Edit an event
Given a user is logged in as "aya"
	And a event exist with title_en: "Christmas Party", title_ja: "クリスマスパーティ"
When I go to the events page
	And I follow "Edit" within that event
	And I fill in "Title (en)*" with ""
	And I press "Update"
Then I should be redirected to the error show page of that event
When I fill in "Title (en)*" with "Christmas Yeah!"
	And I press "Update"
Then I should be redirected to the show page of that event

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
  
Scenario: Passed events faded / seperate table (NOT IMPLEMENTED)
Given not implemented