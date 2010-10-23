Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"
And a theme exists
And a word exists with japanese: "童謡を", reading: "どうようを", meaning: "children's song"
And a glossary exists with japanese: "母と二人で童謡を歌った", english: "I sang a children's song with my mother", word: the word, theme: that theme
And a kanji: "song" exists with title: "童"
And a meaning: "song" exists with title: "song"
And a kanjis_meanings exists with kanji: that kanji, meaning: that meaning
And a kanji: "chanting" exists with title: "謡"
And a meaning: "chanting" exists with title: "chanting"
And a kanjis_meanings exists with kanji: that kanji, meaning: that meaning
And a user is logged in as "johan"
When I go to the quiz init glossaries page

@kanji @first
Scenario: First question - Kanji question
When I answer with "母と二人で童謡を歌った, children's song, どうようを"
Then I should see "母と二人で童謡を歌った" as question
And I should see "song" as correct answer
And I should see "****" as part answer

@kanji @second
Scenario: First question - Second kanji question
When I answer with "母と二人で童謡を歌った, children's song, どうようを, song"
Then I should see "母と二人で童謡を歌った" as question
And I should see "chanting" as correct answer
And I should see "********" as part answer

Scenario: First question - No third kanji question
When I answer with "母と二人で童謡を歌った, children's song, どうようを, song, chanting"
Then I should be redirected to the glossaries page
