Background:
Given a setting exists with name: "main"
	And a user: "aya" exists with username: "aya", role: "admin", language: "en"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant", language: "ja"
	And a gallery: "christmas" exists
	And a event: "christmas" exist with title_en: "Christmas Party", gallery: gallery "christmas"
	
Scenario: A comment cannot be blank
Given a user is logged in as "kurosawa"
	When I go to the show page of event "christmas"
	And I press 'comments.add'
Then I should be redirected to the show page of that event
	And I should see "コメントは空白のままにしておく事は出来ません"

Scenario: Add a comment
Given a user is logged in as "kurosawa"
When I go to the show page of event "christmas"
	And I fill in "Comment*" with "Fuck Christmas!"
	And I press 'comments.add'
Then I should see "Fuck Christmas!"

Scenario Outline: Edit & delete commennts (NOT IMPLEMENTED)
Given a comment: "fuck_christmas" exists with comment: "Fuck Christmas!", user: user "aya", event: event "christmas"
	And a comment: "fuck_santa" exists with comment: "Fuck Santa!", user: user "kurosawa", event: event "christmas"
	And a user is logged in as "<user>"
When I go to the show page of event "christmas"
Then I should <view1> within comment "fuck_santa"
  And I should <view2> within comment "fuck_christmas"
Examples:
| user      | view1                   | view2                       |
| kurosawa  | see links "編集, 削除"  | not see links "編集, 削除"  |
| aya       | see links "Edit, Del"   | see links "Edit, Del"       |

Scenario: Edit & delete commennts (NOT IMPLEMENTED)
Given not implemented