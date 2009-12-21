Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user exists with username: "kurosawa", role: "admin", language: "ja"
	And a gallery: "Christmas" exists
	And a event exist with title_en: "Christmas Party", date: "2009-12-19", gallery: gallery "Christmas"
	
Scenario: Add a caption in English
Given a user is logged in as "johan"
	And I add a photo "sadako"
	And I follow "sadako"
	And I follow "Edit"
	And I fill in "photo_caption_ja" with "japanese"
	And I press "Update"
	And I follow "sadako"
Then I should see "japanese"
When I follow "Edit"
	And I fill in "photo_caption_en" with "english"
	And I press "Update"
	And I follow "sadako"
Then I should see "english"	

Scenario: Add a caption in Japanese
Given a user is logged in as "kurosawa"
	And I add a photo "sadako" in Japanese
	And I follow "sadako"
	And I follow "編集"
	And I fill in "photo_caption_en" with "english"
	And I press "更新"
	And I follow "sadako"
Then I should see "english"
When I follow "編集"
	And I fill in "photo_caption_ja" with "japanese"
	And I press "更新"
	And I follow "sadako"
Then I should see "japanese"	