Background:
Given a setting exists with name: "main"
	And a onyomi: "a" exists with reading: "ア"
	And a kunyomi: "tsu.ku" exists with reading: "つ.く"
	And a meaning: "Asia" exists with title: "Asia"
	And a meaning: "-ous" exists with title: "-ous"
	And a kanji: "Asia" exists with title: "亜"
	And a kanjis_onyomis exists with kanji: kanji "Asia", onyomi: onyomi "a"
	And a kanjis_kunyomis exists with kanji: kanji "Asia", kunyomi: kunyomi "tsu.ku"
	And a kanjis_meanings exists with kanji: kanji "Asia", meaning: meaning "Asia"
	And a kanjis_meanings exists with kanji: kanji "Asia", meaning: meaning "-ous"
	And a user exists with username: "johan", role: "kanji_maniac", language: "en"
	And a user is logged in as "johan"

Scenario: Links from kanji index
When I go to the kanjis page
	And I follow "ア"
Then I should be redirected to the show page for that onyomi
When I go to the kanjis page
	And I follow "つ.く"
Then I should be redirected to the show page for that kunyomi
When I go to the kanjis page
Then I should see "Asia, -ous"
When I follow "-ous"
Then I should be redirected to the show page for meaning: "-ous"
When I go to the kanjis page
	And I follow "亜"
Then I should be redirected to the show page for that kanji

Scenario: Show page
When I go to the show page for that kanji
Then I should see "亜" within "legend"
	And I should see "Onyomi: ア"
	And I should see "Kunyomi: つ.く"
	And I should see "Meaning: Asia, -ous"
When I follow "ア"
Then I should be redirected to the show page for that onyomi
When I go to the show page for that kanji
When I follow "つ.く"
Then I should be redirected to the show page for that kunyomi
When I go to the show page for that kanji
When I follow "Asia"
Then I should be redirected to the show page for meaning: "Asia"
