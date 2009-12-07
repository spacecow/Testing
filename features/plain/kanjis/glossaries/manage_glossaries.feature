Background:
Given a setting exists with name: "main"
  And a user exists with username: "johan", role: "kanji_maniac", language: "ja"
	And a user is logged in as "johan"
  And I go to the glossaries page
	
Scenario: Start a quiz
Given a glossary exists with japanese: "日に照らされた縁側"
When I follow "クイズ"
Then I should see "クイズ" within "legend"
  And I should see "日に照らされた縁側"

Scenario: Create a new glossary
When I follow 'glossaries.new'
  And I fill in "日本語*" with "障子に映る人影"
  And I fill in "ひらがな*" with "しょうじ"
  And I press 'create'
Then I should be redirected to the error glossaries page
  And I should see "Kanji を入力してください。"
When I fill in "漢字*" with "障子"
  And I press 'create'
Then I should be redirected to the new glossary page
  And I should not see "Successfully created glossary."
  
Scenario: Cannot create the same glossary
Given a glossary exists with japanese: "日に照らされた縁側"
When I follow 'glossaries.new'
  And I fill in "日本語*" with "日に照らされた縁側"
  And I press 'create'
Then I should be redirected to the error glossaries page
  And I should see "Japanese はすでに存在します。"
  

