Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"
And a theme exists
And a word: "douyou" exists with japanese: "童謡", reading: "どうよう", meaning: "children's song"
And a glossary exists with japanese: "母と二人で童謡を歌った", english: "I sang a children's song with my mother", word: word "douyou", state: 1, theme: that theme
And a word: "douwa" exists with japanese: "童話", reading: "どうわ", meaning: "fairy tale"
And a glossary exists with japanese: "アンデルセン童話を読んだ", english: "I read an Andersen fairy tale", word: word "douwa", theme: that theme
And a kanji exists with title: "童"
And a meaning exists with title: "song"
And a kanjis_meanings exists with kanji: that kanji, meaning: that meaning
And a kanji: "chanting" exists with title: "謡"
And a meaning: "chanting" exists with title: "chanting"
And a kanjis_meanings exists with kanji: that kanji, meaning: that meaning
And a kanji: "talk" exists with title: "話"
And a meaning: "talk" exists with title: "talk"
And a kanjis_meanings exists with kanji: that kanji, meaning: that meaning
And a user is logged in as "johan"
When I go to the quiz init glossaries page

Scenario: Second glossary - Sentence question
When I answer with "母と二人で童謡を歌った, children's song, どうよう, song, どうわ, fairy tale, chanting"
Then I should see "I read an Andersen fairy tale" as question

Scenario: Second glossary - English question
When I answer with "母と二人で童謡を歌った, children's song, どうよう, song, どうわ, fairy tale, chanting, アンデルセン童話を読んだ"
Then I should see "アンデルセン童話を読んだ" as question
And I should see "fairy tale" as correct answer

Scenario: Second glossary - Reading question
When I answer with "母と二人で童謡を歌った, children's song, どうよう, song, どうわ, fairy tale, chanting, アンデルセン童話を読んだ, fairy tale"
Then I should see "アンデルセン童話を読んだ" as question
And I should see "どうわ" as correct answer

Scenario: Second glossary - Kanji question
When I answer with "母と二人で童謡を歌った, children's song, どうよう, song, どうわ, fairy tale, chanting, アンデルセン童話を読んだ, fairy tale, どうわ"
Then I should see "アンデルセン童話を読んだ" as question
And I should see "song" as correct answer

Scenario: Second glossary - Relation question, Reading
When I answer with "母と二人で童謡を歌った, children's song, どうよう, song, どうわ, fairy tale, chanting, アンデルセン童話を読んだ, fairy tale, どうわ, song"
Then I should see "母と二人で童謡を歌った" as question
And I should see "どうよう" as correct answer

Scenario: Second glossary - Relation question, Meaning
When I answer with "母と二人で童謡を歌った, children's song, どうよう, song, どうわ, fairy tale, chanting, アンデルセン童話を読んだ, fairy tale, どうわ, song, どうよう"
Then I should see "母と二人で童謡を歌った" as question
And I should see "children's song" as correct answer

Scenario: Second glossary - Kanji question
When I answer with "母と二人で童謡を歌った, children's song, どうよう, song, どうわ, fairy tale, chanting, アンデルセン童話を読んだ, fairy tale, どうわ, song, どうよう, children's song"
Then I should see "アンデルセン童話を読んだ" as question
And I should see "talk" as correct answer

Scenario: Glossaries finished
When I answer with "母と二人で童謡を歌った, children's song, どうよう, song, どうわ, fairy tale, chanting, アンデルセン童話を読んだ, fairy tale, どうわ, song, どうよう, children's song, talk"
Then I should be redirected to the glossaries page

