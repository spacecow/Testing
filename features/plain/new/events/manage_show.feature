@show_event
Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "registrant", language: "en"
	And a user exists with username: "kurosawa", role: "registrant", language: "ja"
	And a gallery: "christmas" exists
	And a photo exists with gallery: that gallery
	And a event exist with title_en: "Christmas Party!", title_ja: "クリスマスパーティ", date: "2009-12-19", description_en: "It's Christmas!", description_ja: "クリスマスタイム！", gallery: gallery "christmas"	

Scenario: Display the show page in japanese
Given a user is logged in as "kurosawa"
When I go to the show page for that event
Then I should see "クリスマスパーティ - 2009-12-19" within "legend"
	And I should see "クリスマスタイム！"
	And I should see "参加者: 0"	

Scenario: Display the show page in english
Given a user is logged in as "johan"
When I go to the show page for that event
Then I should see "Christmas Party! - 2009-12-19" within "legend"
	And I should see "It's Christmas!"
	And I should see "Applicants: 0"

Scenario: Link to a photo
Given a user is logged in as "johan"
When I go to the show page for that event
When I follow "sadako"
Then I should be redirected to the show page of that photo
	And I should not see "Sorry, you are not allowed to access that page."
	
Scenario: Link to the gallery
Given a user is logged in as "johan"
When I go to the show page for that event
When I follow "Gallery"
Then I should be redirected to the show page of that gallery
	And I should not see "Sorry, you are not allowed to access that page."
	
Scenario: Link to registrant
Given a user is logged in as "johan"
When I go to the show page for that event
When I press "Apply"
Then I should not see "Sorry, you are not allowed to access that page."

Scenario: You are not registered for this party yet!! (NOT IMPLEMENTED)
Given not implemented