Background:
Given a setting exists with name: "main"
	And a user exists with username: "aya", role: "registrant", language: "ja"
	And a user is logged in as "aya"
	And a gallery: "christmas" exists
	And a event: "christmas" exist with title_en: "Christmas Party", gallery: gallery "christmas"
	
Scenario: A comment cannot be blank
When I go to the show page of event "christmas"
	And I press 'comments.add'
Then I should be redirected to the show page of that event
	And I should see "コメントは空白のままにしておく事は出来ません"

Scenario: Add a comment
When I go to the show page of event "christmas"
	And I fill in "Comment*" with "bajs"
	And I press 'comments.add'
Then I should see "bajs"