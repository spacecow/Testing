Background:
	Given a setting exist with name: "main"

Scenario: Exception with kunyomi that does not have a word
Given a glossary exist with japanese: "津波"
	And a kanji: "tsu" exists with title: "津"
	And a kanji: "wave" exists with title: "波"
	And a kunyomi: "tsu" exists with reading: "つ"
	And a kunyomi: "nami" exists with reading: "なみ"
	And kunyomi "tsu" is one of kanji "tsu"'s kunyomis
	And kunyomi "nami" is one of kanji "wave"'s kunyomis
	And a word: "wave" exists with japanese: "波", reading: "なみ", meaning: "wave (P)"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user is logged in as "johan"
When I go to the quiz init glossaries page
	Then I should see "Reading? (波)" as question	
	
@something
Scenario: something
Given a glossary exists with japanese: "東京タワー"
	And a kanji: "east" exists with title: "東"
	And a kanji: "capital" exists with title: "京"
	And a kunyomi: "higashi" exists with reading: "ひがし"
	And a kunyomi: "miyako" exists with reading: "みやこ"
	And kunyomi "higashi" is one of kanji "east"'s kunyomis
	And kunyomi "miyako" is one of kanji "capital"'s kunyomis
	And a word: "higashi" exists with japanese: "東", reading: "ひがし", meaning: "east"
	And a word: "kyou" exists with japanese: "京", reading: "きょう", meaning: "imperial capital"
	And a word: "kei" exists with japanese: "京", reading: "けい", meaning: "ten quadrillion"
	And a word: "miyako" exists with japanese: "京", reading: "みやこ", meaning: "capital"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user is logged in as "johan"
When I go to the quiz init glossaries page
#And I answer with "higashi, east"
#Then I should see "Reading? (京)" as question	