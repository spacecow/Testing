@events
Background:
Given a setting exists with name: "main"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant", language: "ja"

Scenario: Display the event list in English and Japanese
Given a user is logged in as "kurosawa"
	And an event exist with title_en: "Christmas Party", title_ja: "クリスマスパーティ", start_date: "2009-12-19 19:00", end_date: "2009-12-19 21:00", description_en: "It's Christmas!", description_ja: "クリスマスタイム！", place: "141", cost: "2500円, non Japanese free"
When I go to the events page
Then I should see "過去のイベント" within "div#past_events h1"
	And I should see "div#past_events table#past_events" table
  |	イベント名					|	日時										|	場所	|	会費											|
  |	クリスマスパーティ	|	2009-12/19 19:00 - 21:00	|	141				|	2500円, non Japanese free	|	
When I follow 'edit_profile'
	And I select "英語" from "このサイトはどんな言語で利用する？*"
	And I press 'update'
Then I should see "Past Events" within "div#past_events h1"
	And I should see "div#past_events table#past_events" table
  |	Event						|	Date&amp;Time											|	Place	|	Cost											|
  |	Christmas Party	|	2009-12/19 19:00 - 21:00	|	141		|	2500円, non Japanese free	|

@list_events
Scenario: Display the list in order
Given an event exists with title_en: "Year-end Party", start_date: "2009-12-23 07:00", end_date: "2009-12-24 13:00", place: "Aizu", cost: "free"
	And an event exists with title_en: "Christmas Party", start_date: "2009-12-19 19:00", end_date: "2009-12-19 21:00", place: "141", cost: "2500円, non Japanese free"
	And an event exists with title_en: "Talking Party 2", start_date: "2012-01-09 18:00", end_date: "2012-01-09 20:00", place: "AER 28th floor", cost: "1500円, non Japanese free"
And an event exists with title_en: "Talking Party 3", place: "AER 28th floor", cost: "1500円, non Japanese free"
	And an event exists with title_en: "Talking Party", start_date: "2010-01-09 18:00", end_date: "2010-01-09 20:00", place: "AER 28th floor", cost: "1500円, non Japanese free"
	And an event exists with title_en: "New Year Party", start_date: "2009-12-31 20:00", end_date: "2010-01-01 05:00", place: "Bar Isn't It", cost: "2500円"
	And a user is logged in as "aya"
When I go to the events page
Then I should see "div#upcoming_events table#upcoming_events" table
|	Event						|	Date&amp;Time												|	Place						|	Cost											|
|	Talking Party 2	|	2012-01/09 18:00 - 20:00						|	AER 28th floor	|	1500円, non Japanese free	|
|	Talking Party 2	|	To be announced											|	AER 28th floor	|	1500円, non Japanese free	|
And I should see "div#past_events table#past_events" table
|	Event						|	Date&amp;Time												|	Place						|	Cost											|
|	Talking Party		|	01/09 18:00 - 20:00									|	AER 28th floor	|	1500円, non Japanese free	|
|	New Year Party	|	2009-12/31 20:00 - 2010-01/01 05:00	|	Bar Isn't It		|	2500円										|
|	Year-end Party	|	2009-12/23 07:00 - 12/24 13:00			|	Aizu						|	free											|
|	Christmas Party	|	2009-12/19 19:00 - 21:00						|	141							|	2500円, non Japanese free	|

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

Scenario: Events with no start date should be put in upcoming events (NOT IMPLEMENTED)
Given not implemented

Scenario: Display events with no dates in table (NOT IMPLEMENTED)
Given not implemented

Scenario: Should be able to display only date (NOT IMPLEMENTED)
Given not implemented