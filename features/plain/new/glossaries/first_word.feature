Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"
And a theme exists
And a word exists with japanese: "童謡", reading: "どうよう", meaning: "children's song"
And a glossary exists with japanese: "母と二人で童謡を歌った", english: "I sang a children's song with my mother", word: that word, theme: that theme
And a word: "douwa" exists with japanese: "童話", reading: "どうわ", meaning: "fairy tale"
And a glossary exists with japanese: "アンデルセン童話を読んだ", english: "I read an Andersen fairy tale", word: word "douwa", theme: that theme
And a kanji: "song" exists with title: "童"
And a meaning: "song" exists with title: "song"
And a kanjis_meanings exists with kanji: that kanji, meaning: that meaning
And a kanji: "chanting" exists with title: "謡"
And a meaning: "chanting" exists with title: "chanting"
And a kanjis_meanings exists with kanji: that kanji, meaning: that meaning
And a user is logged in as "johan"
When I go to the quiz init glossaries page

@word @first @reading
Scenario: First question - Word reading
When I answer with "母と二人で童謡を歌った, children's song, どうよう, song"
Then I should see "アンデルセン童話を読んだ" as question
And I should see "どうわ" as correct answer
And I should see "＊＊＊" as part answer

@word @first @meaning
Scenario: First question - Word meaning
When I answer with "母と二人で童謡を歌った, children's song, どうよう, song, どうわ"
Then I should see "アンデルセン童話を読んだ" as question
And I should see "fairy tale" as correct answer
And I should see "***** ****" as part answer

@kanji @second
Scenario: First question - Second kanji
When I answer with "母と二人で童謡を歌った, children's song, どうよう, song, どうわ, fairy tale"
Then I should see "母と二人で童謡を歌った" as question
And I should see "chanting" as correct answer
And I should see "********" as part answer
