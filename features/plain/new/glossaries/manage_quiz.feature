Background:
Given a setting exist with name: "main"
	And a kanji: "netsu" exist with title: "熱"
	And a meaning: "heat" exists with title: "heat"
	And a meaning: "temperature" exists with title: "temperature"
	And a meaning: "fever" exists with title: "fever"
	And a meaning: "mania" exists with title: "mania"
	And a meaning: "passion" exists with title: "passion"
	And meaning "heat, temperature, fever, mania, passion" is kanji "netsu"'s meanings
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"

@reading
Scenario: Reading
Given a glossary exist with japanese: "熱帯魚"
	And a word: "nettaigyo" exists with japanese: "熱帯魚", reading: "ねったいぎょ", meaning: "tropical fish"
	And a word: "nettai" exists with japanese: "熱帯", reading: "ねったい", meaning: "tropics"
	And a word: "netsu" exists with japanese: "熱", reading: "ねつ", meaning: "fever, temperature"
	And a word: "obi" exists with japanese: "帯", reading: "おび", meaning: "obi"
	And a word: "sakana" exists with japanese: "魚", reading: "さかな", meaning: "fish"
	And a user is logged in as "johan"
When I go to the quiz init glossaries page
Then I should see "Reading?" within "div#question"
	And "熱帯魚" should be marked
	And I should see "nettaigyo" within "div#correct"	
	And I should see "*********" within "div#part"
When I fill in "answer" with "nettaigyo"
	And I press "Next"
Then I should see "Meaning?" within "div#question"
	And "熱帯魚" should be marked
	And I should see "tropical fish" within "div#correct"	
	And I should see "******** ****" within "div#part"

@banned
Scenario: Banned words
Given a glossary exists with japanese: "システム開発"
	And a word: "system" exists with japanese: "システム", reading: "", meaning: "system"
	And a word: "sys" exists with japanese: "シス", reading: "", meaning: "sys"
	And a word: "development" exists with japanese: "開発", reading: "かいはつ", meaning: "development, exploitation"
	And a user is logged in as "johan"
When I go to the quiz init glossaries page
Then "システム" should be marked
When I fill in "answer" with ""
	And I press "Next"
Then "システム" should be marked
When I fill in "answer" with "system"
	And I press "Next"
Then "開発" should be marked

@sequence
Scenario: Sequence
Given a glossary exist with japanese: "熱帯魚"
	And a word: "nettaigyo" exists with japanese: "熱帯魚", reading: "ねったいぎょ", meaning: "tropical fish"
	And a word: "nettai" exists with japanese: "熱帯", reading: "ねったい", meaning: "tropics"
	And a word: "netsu" exists with japanese: "熱", reading: "ねつ", meaning: "fever, temperature"
	And a word: "obi" exists with japanese: "帯", reading: "おび", meaning: "obi"
	And a word: "sakana" exists with japanese: "魚", reading: "さかな", meaning: "fish"
	And a user is logged in as "johan"
When I go to the quiz init glossaries page
Then "熱帯魚" should be marked
When I fill in "answer" with "nettaigyo"
	And I press "Next"
When I fill in "answer" with "tropical fish"
	And I press "Next"
Then "熱帯" should be marked
When I fill in "answer" with "nettai"
	And I press "Next"
When I fill in "answer" with "tropics"
	And I press "Next"
Then "熱" should be marked
When I fill in "answer" with "netsu"
	And I press "Next"
When I fill in "answer" with "fever, temperature"
	And I press "Next"
Then "帯" should be marked
When I fill in "answer" with "obi"
	And I press "Next"
When I fill in "answer" with "obi"
	And I press "Next"
Then "魚" should be marked
When I fill in "answer" with "sakana"
	And I press "Next"
When I fill in "answer" with "fish"
	And I press "Next"
Then "熱帯魚" should be marked	

#Scenario: Going on to the next kanji
#Given a kanji: "obi" exist with title: "帯"
#	And a kanji: "fish" exist with title: "魚"
#	And a meaning: "sash" exist with title: "sash"
#	And a meaning: "belt" exist with title: "belt"
#	And a meaning: "obi" exist with title: "obi"
#	And a meaning: "zone" exist with title: "zone"
#	And a meaning: "region" exist with title: "region"
#	And a meaning: "fish" exists with title: "fish"
#	And meaning "sash, belt, obi, zone, region" is kanji "obi"'s meanings
#	And a meaning "fish" is one of kanji "fish"'s meanings
#	And a user is logged in as "johan"
#When I go to the quiz init glossaries page
#	And I fill in "answer" with "heat, temperature, fever, mania, passion"
#	And I press "Next"
#Then "帯" should be marked
#	And I should see "Meaning?" within "div#question"
#	And I should see "****, ****, ***, ****, ******" within "div#part"
#	And I should see "sash, belt, obi, zone, region" within "div#correct"
#When I fill in "answer" with "sash, belt, obi"
#	And I press "Next"
#And I fill in "answer" with "zone, region"
#	And I press "Next"
#Then "魚" should be marked