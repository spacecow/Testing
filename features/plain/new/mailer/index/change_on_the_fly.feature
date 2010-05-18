Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a course exists with name: "Ruby I", level_en: "gram.", level_ja: "文法"
	And a klass: "1" exists with date: "2011-12-24", course: that course, start_time: "12:00", end_time: "13:00"
	And a courses_teacher exists with course: that course, teacher: user "thomas"
	And a teaching exists with klass: that klass, teacher: user "thomas", status_mask: 33
	And a user is logged in as "johan"

@day
Scenario: Change day
When I browse to the "Daily Mail" page for user "thomas" of "December 23, 2011"
	And I select "December 24, 2011" as date in the select menu
Then I should see "12/24(sat) 12:00～13:00(gram.)" within "div#text_message"

@language
Scenario: When changing language not only should the language of the message change, but also the language of the schedule
When I browse to the "Daily Mail" page for user "thomas" of "December 24, 2011"
	And I select "Japanese" as language in the select menu
Then the "body" field should contain the daily teacher reminder mail in japanese
	And I should see "12/24(土) 12:00～13:00(文法)" within "div#text_message"

@teacher
Scenario: Choose teacher
Given a klass: "2" exists with date: "2011-12-24", start_time: "15:56"
	And a teaching exists with klass: klass "2", teacher: user "johan", status_mask: 33
When I browse to the "Daily Mail" page for user "thomas" of "December 24, 2011"
	And I select "Johan Sveholm" as teacher in the select menu
Then I should not see "12:00" within "div#text_message"
	And I should see "15:56" within "div#text_message"

@type
Scenario: Choose type
	And a klass: "2" exists with date: "2011-12-27"
	And a teaching exists with klass: klass "2", teacher: user "thomas"
When I browse to the "Daily Mail" page for user "thomas" of "December 24, 2011"
	And I select "Weekly Teacher Schedule" as type in the select menu
Then the "body" field should contain the weekly teacher schedule mail in english
	And I should see "12/27" within "div#text_message"