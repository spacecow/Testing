Background:
Given a setting exists with name: "main"
	And a user: "aya" exists with username: "aya", role: "admin", language: "en"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant", language: "ja"
	And a user: "thomas" exists with username: "thomas", role: "observer", language: "en"
	And a todo: "chat" exists with subjects_mask: 1, user: user "kurosawa", title: "Chat room", description: "Wouldn't that be fun!"  
	
Scenario: A comment cannot be blank (AJAX)
Given a user is logged in as "kurosawa"
	When I go to the show page of todo "chat"
	And I press "コメントを書き足す"
Then I should be redirected to the show page of that todo
	And I should see "コメントは空白のままにしておく事は出来ません"

Scenario: Add a comment
Given a user is logged in as "kurosawa"
When I go to the show page of todo "chat"
	And I fill in "Comment*" with "I wanna chat!"
	And I press "コメントを書き足す"
Then I should see "I wanna chat!"
	And a comment exists with comment: "I wanna chat!", user: user "kurosawa", todo: todo "chat", event_id: "nil"

Scenario: Add a comment with line feed
Given a user is logged in as "kurosawa"
When I go to the show page of todo "chat"
	And I fill in "Comment*" with "I wanna chat!<br />yeah!"
	And I press "コメントを書き足す"
Then I should see "I wanna chat!yeah!"
When I follow "編集"
Then the "Comment" field should contain "I wanna chat!\r\nyeah!"
When I press "更新"
#Then I should see "I wanna chat!yeah!"	 Dont know why this doesnt work

Scenario Outline: Edit & delete options for comments should be visible for respective role
Given a comment: "fuck_christmas" exists with comment: "Fuck Christmas!", user: user "aya", todo: todo "chat"
	And a comment: "fuck_santa" exists with comment: "Fuck Santa!", user: user "kurosawa", todo: todo "chat"
	And a comment: "fuck_goat" exists with comment: "And fuck his goat!", user: user "thomas", todo: todo "chat"
	And a user is logged in as "<user>"
When I go to the show page of todo "chat"
Then I should <view1> within comment "fuck_santa"
  And I should <view2> within comment "fuck_christmas"
  And I should <view3> within comment "fuck_goat"
Examples:
| user      | view1                   		| view2                       | view3                       |
| kurosawa  | see links "編集, 削除"  		| not see links "編集, 削除"  | not see links "編集, 削除"  |
| aya       | see links "Edit, Del"   		| see links "Edit, Del"       | see links "Edit, Del"       |
| thomas    | not see links "Edit, Del"   | not see links "Edit, Del"   |	see links "Edit, Del"       |

Scenario: Edit a comment
Given a comment exists with comment: "Fuck Christmas!", user: user "thomas", todo: todo "chat"
	And a user is logged in as "thomas"
Then 1 comments should exist
When I go to the show page of todo "chat"
	And I follow "Edit" within that comment
	And I fill in "comment_comment" with ""
	And I press "Update"
Then I should be redirected to the error show page of that comment
	And I should see "Comment cannot be left blank."
	And I should see "Fuck Christmas!"
When I fill in "comment_comment" with "Fuck Santa's goat!"
	And I press "Update"
Then I should be redirected to the show page of its todo
	And I should see "Fuck Santa's goat!"
	And I should not see "Comment cannot be left blank."	
	And 1 comments should exist

Scenario: Delete a comment
Given a comment exists with comment: "I wanna chat!", user: user "thomas", todo: todo "chat"
	And a user is logged in as "thomas"
Then 1 comments should exist
When I go to the show page of todo "chat"
	And I follow "Del" within that comment
Then I should be redirected to the show page of its todo
	And I should not see "I wanna chat!"
	And 0 comments should exist

Scenario: Updated at (NOT IMPLEMENTED)
Given not implemented