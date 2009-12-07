Background:
Given a setting exists with name: "main"
	And a onyomi: "a" exists with reading: "ア"
	And a kanji: "Asia" exists with title: "亜"
	And a kanjis_onyomis exists with kanji: kanji "Asia", onyomi: onyomi "a"
	And a user exists with username: "johan", role: "kanji_maniac", language: "en"
	And a user is logged in as "johan"

Scenario: Show page
When I go to the show page for that onyomi
Then I should see "ア" within "legend"
	And I should see "Kanji: 亜"
When I follow "亜"
Then I should be redirected to the show page for that kanji