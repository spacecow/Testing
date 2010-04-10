Background:
Given a setting exist with name: "main"
	And a glossary exist with japanese: "帯黄色"
	And a word: "tai" exists with japanese: "帯", reading: "たい", meaning: "band"
	And a word: "obi" exists with japanese: "帯", reading: "おび", meaning: "sash"
	And a word: "obiru" exists with japanese: "帯びる", reading: "おびる", meaning: "(v) to wear"
	And a word: "ki" exists with japanese: "黄", reading: "き", meaning: "yellow"
	And a word: "kiru" exists with japanese: "黄る", reading: "きる", meaning: "to yellow"
	And a kanji: "obi" exists with title: "帯"
	And a kanji: "yellow" exists with title: "黄"
	And a kunyomi: "obiru" exists with reading: "お.びる"
	And a kunyomi: "obi" exists with reading: "おび"
	And a kunyomi: "ki" exists with reading: "き"
	And a kunyomi: "kiro" exists with reading: "きろ"
	And a kunyomi: "kiru" exists with reading: "き.る"
	And kunyomi "obiru, obi" are kanji "obi"'s kunyomis
	And kunyomi "ki, kiro, kiru" are kanji "yellow"'s kunyomis
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user is logged in as "johan"
	And I go to the quiz init glossaries page

@kunyomi
Scenario: View of kunyomi question
Then I should see "Reading? (帯びる)" as question
	And I should see "obiru" as correct answer	

@meaning
Scenario: After kunyomi comes meaning and paranthesis are not shown
When I answer with "obiru"
Then I should see "Meaning? (帯びる)" as question
	And I should see "to wear" as correct answer
	
@2nd_kunyomi
Scenario: After meaning comes the next kunyomi
When I answer with "obiru, to wear"
Then I should see "Reading? (帯)" as question
	And I should see "obi" as correct answer
	
Scenario: If a word has two readings, the one decided by the kanjis kunyomi is chosen
When I answer with "obiru, to wear, obi"
Then I should see "Meaning? (帯)" as question
	And I should see "sash" as correct answer
	
Scenario: When a kanjis kunyomis are done for, the quiz continues with the next word in order
When I answer with "obiru, to wear, obi, sash"
Then I should see "Reading? (黄)" as question
	And I should see "ki" as correct answer

Scenario: A kunyomi that does not exist as word should not be displayed
When I answer with "obiru, to wear, obi, sash, ki, yellow"
Then I should see "Reading? (黄る)" as question
	And I should see "kiru" as correct answer