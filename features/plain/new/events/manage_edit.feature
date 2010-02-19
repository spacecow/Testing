@edit
Background:
Given a setting exists with name: "main"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en"

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