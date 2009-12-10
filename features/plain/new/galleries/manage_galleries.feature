Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user is logged in as "johan"
	And a gallery: "happy xmas" exists with description: "This is the Christmas gallery!"
  And a event exist with title_en: "Happy Christmas Party", title_ja: "1", gallery: gallery "happy xmas"
	And a gallery: "non-happy xmas" exists
  And a event exist with title_en: "Non-happy Christmas Party", title_ja: "2", gallery: gallery "non-happy xmas"  

Scenario: Show gallery description if there is one
When I go to the show page of gallery: "happy xmas"
Then I should see "This is the Christmas gallery! Edit"
  And I should see links "Happy Christmas Party, Add Photo, Galleries"
  
Scenario: Don't show gallery description if there is not one
When I go to the show page of gallery: "non-happy xmas"
Then I should not see "This is the Christmas gallery!"
  And I should see links "Non-happy Christmas Party, Edit Gallery, Add Photo, Galleries"  
