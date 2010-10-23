Background:
Given a setting exists with name: "main"
And a user: "johan" exist with username: "johan", role: "god"
And a theme exists
And a word: "boldness" exists with japanese: "円形脱毛症", reading: "えんけいだつもうしょう", meaning: "alopecia areata"
And a word exists with japanese: "円形", reading: "えんけい", meaning: "/(n) (1) round shape/circle/(2) circular form/(P)/"
And a word: "hair" exists with japanese: "毛", reading: "け", meaning: "hair"
And a kanji exists with title: "毛"
And a meaning exists with title: "hair"
And a kanjis_meanings exists with kanji: that kanji, meaning: that meaning
And a glossary exists with japanese: "円形脱毛症が広範囲になった", english: "My spot baldness has widened", word: word "boldness", theme: that theme
And a glossary exists with japanese: "飼い猫の毛のつやが悪くなった", english: "Our cat's fur has lost its luster", word: word "hair", theme: that theme
And a user is logged in as "johan"

Scenario: Chained word - First word, reading
When I go to the quiz init glossaries page with state "1"
Then I should see "円形脱毛症が広範囲になった" as question
And I should see /えんけいだつもうしょう/ as correct answer

Scenario: Chained word - First word, meaning
When I go to the quiz init glossaries page with state "1"
And I answer with "えんけいだつもうしょう"
Then I should see "円形脱毛症が広範囲になった" as question
And I should see /alopecia areata/ as correct answer

Scenario: Chained word - Second word, reading
When I go to the quiz init glossaries page with state "3"
Then I should see "円形脱毛症が広範囲になった" as question
And I should see /えんけい/ as correct answer

Scenario: Chained word ~ Second word, meaning
When I go to the quiz init glossaries page with state "3"
And I answer with "えんけい"
Then I should see "円形脱毛症が広範囲になった" as question
And I should see "circular form" as correct answer

Scenario: Chained word - Kanji
When I go to the quiz init glossaries page with state "5"
Then I should see "円形脱毛症が広範囲になった" as question
And I should see /hair/ as correct answer

Scenario: Chained word - First glossary word, reading
When I go to the quiz init glossaries page with state "6"
Then I should see "飼い猫の毛のつやが悪くなった" as question
And I should see /け/ as correct answer

Scenario: Chained word - First glossary word, meaning
When I go to the quiz init glossaries page with state "6"
And I answer with "け"
Then I should see "飼い猫の毛のつやが悪くなった" as question
And I should see /hair/ as correct answer

Scenario: Second word 
When I go to the quiz init glossaries page with state "6"
And I answer with "け, hair"
Then I should see "Our cat's fur has lost its luster" as question
And I should see /飼い猫の毛のつやが悪くなった/ as correct answer

Scenario: Second word - Kanji 
When I go to the quiz init glossaries page with state "6"
And I answer with "け, hair, 飼い猫の毛のつやが悪くなった"
Then I should see "飼い猫の毛のつやが悪くなった" as question
And I should see /hair/ as correct answer

Scenario: Second word - Kanji 
When I go to the quiz init glossaries page with state "6"
And I answer with "け, hair, 飼い猫の毛のつやが悪くなった, hair"
Then I should see "円形脱毛症が広範囲になった" as question
And I should see /えんけいだつもうしょう/ as correct answer

Scenario: Second word - Kanji 
When I go to the quiz init glossaries page with state "6"
And I answer with "け, hair, 飼い猫の毛のつやが悪くなった, hair, えんけいだつもうしょう"
Then I should see "円形脱毛症が広範囲になった" as question
And I should see "alopecia areata" as correct answer

Scenario: Questioning finished
When I go to the quiz init glossaries page with state "6"
And I answer with "け, hair, 飼い猫の毛のつやが悪くなった, hair, えんけいだつもうしょう, alopecia areata"
Then I should be redirected to the glossaries page
