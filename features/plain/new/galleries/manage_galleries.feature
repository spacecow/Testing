Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user exists with username: "mika", role: "registrant", language: "en"
	And a user exists with username: "reiko", role: "registrant, student, photographer", language: "en"
	And a gallery: "happy xmas" exists with description: "This is the Christmas gallery!"
  And a event exist with title_en: "Happy Christmas Party", title_ja: "1", gallery: gallery "happy xmas", start_date: "2009-12-19"
	And a gallery: "non-happy xmas" exists
  And a event exist with title_en: "Non-happy Christmas Party", title_ja: "2", gallery: gallery "non-happy xmas"  

Scenario: Show gallery description if there is one
Given a user is logged in as "johan"
When I go to the show page of gallery: "happy xmas"
Then I should see "Happy Christmas Party - 2009-12/19 - Gallery" within "legend"
	And I should see "This is the Christmas gallery! Edit"
  And I should see options "Happy Christmas Party, Add Photo, Galleries" within "div.links"
  
Scenario: Don't show gallery description if there is not one
Given a user is logged in as "johan"
When I go to the show page of gallery: "non-happy xmas"
Then I should see "Non-happy Christmas Party - To be announced - Gallery" within "legend"
	And I should not see "This is the Christmas gallery!"
  And I should see links "Non-happy Christmas Party, Edit Gallery, Add Photo, Galleries"  
  And I should see options "Non-happy Christmas Party, Edit Gallery, Add Photo, Galleries" within "div.links"

Scenario: A registrant should be able to see the gallery
Given a user is logged in as "mika"
When I go to the show page of gallery: "happy xmas"
Then I should see "Happy Christmas Party - 2009-12/19 - Gallery" within "legend"
	And I should see options "Happy Christmas Party" within "div.links"
	
Scenario: A photographer should be able to add pictures to a gallery
Given a user is logged in as "reiko"
When I go to the show page of gallery: "happy xmas"
Then I should see "Happy Christmas Party - 2009-12/19 - Gallery" within "legend"
	And I should see options "Happy Christmas Party, Add Photo" within "div.links"