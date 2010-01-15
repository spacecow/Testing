@manage_comments
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "admin, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant, student", language: "ja"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a todo: "chat" exists with subjects_mask: 1, user: user "kurosawa", title: "Chat room", description: "Wouldn't that be fun!"  
	
Scenario: A comment cannot be blank (AJAX)
Given a user is logged in as "kurosawa"
	When I go to the show page of todo "chat"
	And I press "コメントを書き足す"
Then I should be redirected to the show page of that todo
	And I should see "コメントは空白のままにしておく事は出来ません"

@add_comment
Scenario Outline: Add a comment
Given a todo: "reserve" exists with subjects_mask: 4, user: user "<author>", title: "Reservation system"
	And a comment exists with user: user "thomas", todo: that todo
	And a user is logged in as "<user>"
When I go to the show page of todo "reserve"
	And I fill in "Comment*" with "I want it already!"
	And I press "Add Comment"
Then I should see "I want it already!"
	And a comment exists with comment: "I wanna chat!", user: user "<user>", todo: todo "reserve", event_id: "nil"
	And <no> mails should exist
	And a mail <johan> exist with sender: user "<user>", subject: "added#comment", message: "comments.added#Reservation system#todo", recipient: user "johan"
	And a mail <other> exist with sender: user "<user>", subject: "added#comment", message: "comments.added#Reservation system#todo", recipient: user "<author>"
	And a mail <comment> exist with sender: user "<user>", subject: "added#comment", message: "comments.added#Reservation system#todo", recipient: user "thomas"
Examples:
|	author		|	user			|	johan				|	other				|	comment			|	no	|
|	thomas		|	aya				|	should			|	should			|	should 			|	2		|
|	thomas		|	johan			|	should not	|	should			|	should 			|	1		|
|	johan			|	aya				|	should 			|	should			|	should			|	2		|
|	johan			|	johan			|	should not	|	should not	|	should			|	1		|
|	aya				|	thomas		|	should 			|	should			|	should not	|	2		|
|	thomas		|	thomas		|	should 			|	should not	|	should not	|	1		|
|	kurosawa	|	aya				|	should 			|	should			|	should			|	3		|

Scenario: Add a comment with line feed (DONT KNOW WHY THIS DOESNT WORK)
Given a user is logged in as "kurosawa"
When I go to the show page of todo "chat"
	And I fill in "Comment*" with "I wanna chat!<br />yeah!"
	And I press "コメントを書き足す"
Then I should see "I wanna chat!yeah!"
When I follow "編集"
Then the "Comment" field should contain "I wanna chat!\r\nyeah!"
When I press "更新"
#Then I should see "I wanna chat!yeah!"	 Dont know why this doesnt work
Given not implemented

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

@edit_comment
Scenario Outline: Edit a comment
Given a todo: "reserve" exists with subjects_mask: 4, user: user "<author>", title: "Reservation system"
	And a comment exists with comment: "Fuck Christmas!", user: user "<user>", todo: todo "reserve"
	And a comment exists with user: user "thomas", todo: that todo
	And a user is logged in as "<user>"
Then 2 comments should exist
When I go to the show page of todo "reserve"
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
	And 2 comments should exist
	And <no> mails should exist
	And a mail <johan> exist with sender: user "<user>", subject: "updated#comment", message: "comments.updated#Reservation system#todo", recipient: user "johan"	
	And a mail <other> exist with sender: user "<user>", subject: "updated#comment", message: "comments.updated#Reservation system#todo", recipient: user "<author>"
	And a mail <comment> exist with sender: user "<user>", subject: "updated#comment", message: "comments.updated#Reservation system#todo", recipient: user "thomas"
Examples:
Examples:
|	author		|	user			|	johan				|	other				|	comment			|	no	|
|	thomas		|	aya				|	should			|	should			|	should 			|	2		|
|	thomas		|	johan			|	should not	|	should			|	should 			|	1		|
|	johan			|	aya				|	should 			|	should			|	should			|	2		|
|	johan			|	johan			|	should not	|	should not	|	should			|	1		|
|	aya				|	thomas		|	should 			|	should			|	should not	|	2		|
|	thomas		|	thomas		|	should 			|	should not	|	should not	|	1		|
|	kurosawa	|	aya				|	should 			|	should			|	should			|	3		|

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