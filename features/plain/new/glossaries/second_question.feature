Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"
And a word: "douyou" exists with japanese: "童謡", reading: "どうよう", meaning: "children's song"
And a glossary exists with japanese: "母と二人で童謡を歌った", english: "I sang a children's song with my mother", word: word "douyou", state: 1
And a word: "douwa" exists with japanese: "童話", reading: "どうわ", meaning: "fairy tale"
And a glossary exists with japanese: "アンデルセン童話を読んだ", english: "I read an Andersen fairy tale", word: word "douwa"
And a user is logged in as "johan"
When I go to the quiz init glossaries page

Scenario: First glossary - Relation question, English
When I answer with "母と二人で童謡を歌った, children's song, どうよう"
Then the "question" field should contain "童話"
And I should see "fairy tale" as correct answer

Scenario: First glossary - Relation question, Reading
When I answer with "母と二人で童謡を歌った, children's song, どうよう, fairy tale"
Then the "question" field should contain "童話"
And I should see "どうわ" as correct answer

Scenario: Second glossary - Sentence question
When I answer with "母と二人で童謡を歌った, children's song, どうよう, fairy tale, どうわ"
Then the "question" field should contain "I read an Andersen fairy tale"

Scenario: Second glossary - English question
When I answer with "母と二人で童謡を歌った, children's song, どうよう, fairy tale, どうわ, アンデルセン童話を読んだ"
Then the "question" field should contain "童話"
And I should see "fairy tale" as correct answer

Scenario: Second glossary - Reading question
When I answer with "母と二人で童謡を歌った, children's song, どうよう, fairy tale, どうわ, アンデルセン童話を読んだ, fairy tale"
Then the "question" field should contain "童話"
And I should see "どうわ" as correct answer

Scenario: Second glossary - Relation question, English
When I answer with "母と二人で童謡を歌った, children's song, どうよう, fairy tale, どうわ, アンデルセン童話を読んだ, fairy tale, どうわ"
Then the "question" field should contain "童謡"
And I should see "children's song" as correct answer

Scenario: Second glossary - Relation question, Reading
When I answer with "母と二人で童謡を歌った, children's song, どうよう, fairy tale, どうわ, アンデルセン童話を読んだ, fairy tale, どうわ, children's song"
Then the "question" field should contain "童謡"
And I should see "どうよう" as correct answer

Scenario: Glossaries finished
When I answer with "母と二人で童謡を歌った, children's song, どうよう, fairy tale, どうわ, アンデルセン童話を読んだ, fairy tale, どうわ, children's song, どうよう"
Then I should be redirected to the glossaries page

