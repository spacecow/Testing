Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"

Scenario: Create a new glossary
Given a user is logged in as "johan"
And a word exists with japanese: "相談", reading: "そうだん"
When I go to the new glossary page
And I fill in "Japanese" with "お楽しみ会について相談する"
And I fill in "English" with "Discuss a fun day"
And I fill in "Kanji" with "相談"
And I fill in "Hiragana" with "そうだん"
And I press "Create"
Then 1 glossaries should exist
And a glossary should exist with japanese: "お楽しみ会について相談する", english: "Discuss a fun day", word: that word
And I should see "Successfully created glossary." as notice flash message

Scenario: Error when trying to create a glossary with blank japanese
Given a user is logged in as "johan"
When I go to the new glossary page
And I press "Create"
Then I should be redirected to the glossaries page
And I should see "can't be blank" as error message for glossary japanese 

Scenario: Word does not exist
