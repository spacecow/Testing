Background:
Given a setting exist with name: "main"
	And a glossary exist with japanese: "色"
	And a kanji: "colour" exists with title: "色"
	And a meaning: "colour" exists with title: "colour"
	And meaning "colour" is one of kanji "colour"'s meanings
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user is logged in as "johan"

Scenario: When there are no kunyomis, the kanjis meaning is displayed
When I go to the quiz init glossaries page
Then I should see "colour" as correct answer

Scenario: If a part of the answer is given, you will be continue from there
When I go to the quiz init glossaries page
	And I answer with "col"
Then I should see "colour" as correct answer
	And I should see "col***" as part answer

@oending
Scenario: When there are kunyomis, but no words for them, the kanjis meaning is displayed
Given a kunyomi: "ironna" exists with reading: "いろ.んな"
	And kunyomi "ironna" is one of kanji "colour"'s kunyomis
When I go to the quiz init glossaries page