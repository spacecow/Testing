Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"
And a user is logged in as "johan"
And a word: "douyou" exists with japanese: "童謡", reading: "どうよう", meaning: "children's song"
And a theme exists with title: "Test"
And a glossary exists with japanese: "母と二人で童謡を歌った", english: "I sang a children's song with my mother", word: word "douyou", theme: that theme
And a kanji: "song"  exists with title: "童"
And a meaning: "song" exists with title: "song"
And a kanjis_meanings exists with kanji: that kanji, meaning: that meaning
And a kanji: "chanting" exists with title: "謡"
And a meaning: "chanting" exists with title: "chanting"
And a kanjis_meanings exists with kanji: that kanji, meaning: that meaning
When I go to the quiz init glossaries page

Scenario: First question - Sentence View
Then I should see "I sang a children's song with my mother" as question
And I should see "母と二人で童謡を歌った" as correct answer
And I should see "＊＊＊＊＊＊＊＊＊＊＊" as part answer

Scenario: First question - A partly answer for Sentence
And I answer with "二人で"
Then I should see "I sang a children's song with my mother" as question
And I should see "母と二人で童謡を歌った" as correct answer
And I should see "＊＊二人で＊＊＊＊＊＊" as part answer

@partly
Scenario: First question - Correct answer after a partly answer
When I answer with "母と二人で"
Then I should see "I sang a children's song with my mother" as question
And I should see "母と二人で童謡を歌った" as correct answer
And I should see "母と二人で＊＊＊＊＊＊" as part answer
When I answer with "童謡を歌った"
Then I should see "children's song" as correct answer

Scenario: First question - Sentence question
When I answer with "母と二人で童謡を歌った"
Then I should see "母と二人で童謡を歌った" as question
And I should see "children's song" as correct answer
And I should see "********'* ****" as part answer

Scenario: First question - English question
When I answer with "母と二人で童謡を歌った, children's song"
Then I should see "母と二人で童謡を歌った" as question
And I should see "どうよう" as correct answer
And I should see "＊＊＊＊" as part answer

Scenario: First question - Partly answer for English
When I answer with "母と二人で童謡を歌った, children"
Then I should see "母と二人で童謡を歌った" as question
And I should see "children's song" as correct answer
And I should see "children'* ****" as part answer
