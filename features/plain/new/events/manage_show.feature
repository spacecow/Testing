@event_show
Background:
Given a setting exists with name: "main"
	And a user exists with username: "kurosawa", role: "registrant", language: "ja"
	And a user exists with username: "johan", role: "admin, teacher", language: "en"
	And a user exists with username: "reiko", role: "registrant", language: "en"
	And a gallery: "christmas" exists
	And a photo exists with gallery: that gallery
	And an event: "christmas" exist with title_en: "Christmas Party!", title_ja: "クリスマスパーティ", start_date: "2009-12-19 19:00", end_date: "2009-12-19 21:00", description_en: "It's Christmas!", description_ja: "クリスマスタイム！", gallery: gallery "christmas", due_date: "2009-12-10 23:59", place: "141", cost: "2500 yen for Japanese, free for non Japanese", pay_method: "cash"
	And an event: "yearend" exist with title_en: "Year-end Party!", start_date: "2009-12-23 07:00", end_date: "2009-12-24 13:00", due_date: "2009-12-10 23:59", place: "Fukushima", cost: "free", pay_method: "none"
	And an event: "space" exist with title_en: "Space Opera"

Scenario: Display the show page in japanese
Given a user is logged in as "kurosawa"
When I go to the show page for event "christmas"
Then I should see "クリスマスパーティ" within "legend"
	And I should see "クリスマスタイム！"
	And I should see "参加者: 0"	

Scenario: Display the show page for a short event
Given a user is logged in as "reiko"
When I go to the show page for event "christmas"
Then I should see "Christmas Party!" within "legend"
	And I should see "It's Christmas!"
	And I should see "Date&Time: 2009-12-19 19:00 - 21:00"
	And I should see "Due date: 2009-12-10 23:59"
	And I should see "Place: 141"
	And I should see "Cost: 2500 yen for Japanese, free for non Japanese"
	And I should see "Pay method: cash"
	And I should see "Applicants: 0"
	
Scenario: Display the show page for a long event
Given a user is logged in as "reiko"
When I go to the show page for event "yearend"
Then I should see "Date&Time: 2009-12-23 07:00 - 2009-12-24 13:00"
	And I should see "Due date: 2009-12-10 23:59"
	And I should see "Place: Fukushima"
	And I should see "Cost: free"	
	And I should see "Pay method: none"
	And I should see "Applicants: 0"

Scenario: Display the show page for an event which info has not been decided yet
Given a user is logged in as "reiko"
When I go to the show page for event "space"
Then I should see "Date&Time: To be announced"
	And I should see "Due date: To be announced"
	And I should see "Place: To be announced"
		And I should see "Cost: To be announced"
	And I should see "Pay method: To be announced"
	And I should see "Applicants: 0"

Scenario: Link to a photo
Given a user is logged in as "reiko"
When I go to the show page for event "christmas"
When I follow "sadako"
Then I should be redirected to the show page of that photo
	And I should not see "Sorry, you are not allowed to access that page."
	
Scenario: Link to the gallery
Given a user is logged in as "johan"
When I go to the show page for event "christmas"
When I follow "Gallery"
Then I should be redirected to the show page of that gallery
	And I should not see "Sorry, you are not allowed to access that page."
	
Scenario: Link to registrant
Given a user is logged in as "johan"
When I go to the show page for event "christmas"
When I press "Apply"
Then I should not see "Sorry, you are not allowed to access that page."