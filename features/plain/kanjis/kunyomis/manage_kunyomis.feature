Background:
Given a setting exists with name: "main"
  And a kunyomi: "tsu.ku" exists with reading: "つ.く"
  And a kanji: "Asia" exists with title: "亜"
  And a kanjis_kunyomis exists with kanji: kanji "Asia", kunyomi: kunyomi "tsu.ku"
  And a user exists with username: "johan", role: "kanji_maniac", language: "en"
  And a user is logged in as "johan"

Scenario: Show page
When I go to the show page for that kunyomi
Then I should see "つ.く" within "legend"
  And I should see "Kanji: 亜"
When I follow "亜"
Then I should be redirected to the show page for that kanji
