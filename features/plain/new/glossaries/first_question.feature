Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"
And a user is logged in as "johan"
And a word: "douyou" exists with japanese: "童謡", reading: "どうよう"
And a glossary exists with japanese: "母と二人で童謡を歌った", english: "I sang a children's song with my mother", word: word "douyou"
When I go to the quiz init glossaries page

Scenario: First question - Sentence
Then the "question" field should contain "I sang a children's song with my mother"
And I should see "母と二人で童謡を歌った" as correct answer
And I should see "＊＊＊＊＊＊＊＊＊＊＊" as part answer

Scenario: First question - A partly answer
And I answer with "二人で"
Then the "question" field should contain "I sang a children's song with my mother"
And I should see "母と二人で童謡を歌った" as correct answer
And I should see "＊＊二人で＊＊＊＊＊＊" as part answer

Scenario: First question - A correct answer
And I answer with "母と二人で童謡を歌った"
Then the "question" field should contain "童謡"
And I should see "どうよう" as correct answer
And I should see "＊＊＊＊" as part answer



