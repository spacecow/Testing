Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	
Scenario: Generate database
When I generate the word database from file "edict2.utf"
Then a word should exist with japanese: "エアタオル", meaning: "/(n) air towel/"
	And a word should exist with japanese: "按摩師", reading: "あんまし", meaning: "/(oK) (n) masseuse/masseur/"
	And a word should exist with japanese: "破家", reading: "ばか", meaning: "/(n) (1) fool/idiot/trivial matter/folly/absurdity/(adj-na) (2) foolish/stupid/dull/absurd/ridiculous/"
	And 3 words should exist