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
	Then I should see "Reading? (津)" as question	