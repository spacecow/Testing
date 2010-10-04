Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"
And a word: "douyou" exists with japanese: "童謡", reading: "どうよう"
And a glossary exists with japanese: "母と二人で童謡を歌った", english: "I sang a children's song with my mother", word: word "douyou", state: 1
And a word: "douwa" exists with japanese: "童話", reading: "どうわ"
And a glossary exists with japanese: "アンデルセン童話を読んだ", english: "I read an Andersen fairy tale", word: word "douwa"
And a user is logged in as "johan"
When I go to the quiz init glossaries page

Scenario: First relation question
When I answer with "母と二人で童謡を歌った, どうよう"
Then the "question" field should contain "童話"
And I should see "どうわ" as correct answer
And I should see "＊＊＊" as part answer

Scenario: Next glossary
When I answer with "母と二人で童謡を歌った, どうよう, どうわ"
Then the "question" field should contain "I read an Andersen fairy tale"
