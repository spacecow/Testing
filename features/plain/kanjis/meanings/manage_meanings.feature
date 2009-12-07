Background:
Given a setting exists with name: "main"
  And a meaning "Asia" exists with title: "Asia"
  And a meaning "-ous" exists with title: "-ous"
  And a kanji: "Asia" exists with title: "亜"
  And a kanjis_meanings exists with kanji: kanji "Asia", meaning: meaning "Asia"
  And a kanjis_meanings exists with kanji: kanji "Asia", meaning: meaning "-ous"
  And a user exists with username: "johan", role: "kanji_maniac", language: "en"
  And a user is logged in as "johan"

Scenario: Show page
When I go to the show page for meaning: "-ous"
Then I should see "-ous" within "legend"
  And I should see "Kanji: 亜"
When I follow "亜"
Then I should be redirected to the show page for that kanji
