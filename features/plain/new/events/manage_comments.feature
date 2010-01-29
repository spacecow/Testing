@manage_comments
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "admin", language: "en", name: "Johan Sveholm"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant", language: "ja"
	And a user: "reiko" exists with username: "reiko", role: "registrant, student", language: "ja"
	And a user: "aya" exists with username: "aya", role: "admin", language: "en"
	And a user: "thomas" exists with username: "thomas", role: "observer", language: "en"
	And a gallery: "christmas" exists
	And a event: "christmas" exist with title_en: "Christmas Party", gallery: gallery "christmas"

Scenario: Move comment with LF and create a new Todo
Given a comment: "fuck" exists with comment: "Fuck Christmas!<br />and his goat!", event: event "christmas", user: user "kurosawa"
	And a user is logged in as "johan"
When I go to the show page of that event
	And I press "Go!"
Then I should be redirected to the new todo page
	And the "Description" field should not contain "Fuck Christmas! and his goat!"
	And the "Description" field should contain "Fuck Christmas!\n"
	And the "Description" field should contain "and his goat!"
When I press "Create"
Then the "Description" field should not contain "Fuck Christmas!&lt;br /&gt;"
	And the "Description" field should contain "Fuck Christmas!\n"
When I fill in "Title" with "Christmas Spirit"
	And I check "Bug"
	And I press "Create"
Then I should be redirected to the show page of event "christmas"
	And a todo should exist with title: "Christmas Spirit", description: "Fuck Christmas!<br />", subjects_mask: 1, user: user "kurosawa"
	And 0 comments should exist
	
@comment
Scenario: Move an event comment with LF to an existing todo
Given a comment: "fuck" exists with comment: "Fuck Christmas!<br />and his goat!", event: event "christmas", user: user "kurosawa"
	And a todo exists with title: "Chatter room", subjects_mask: 1
	And a user is logged in as "johan"
When I go to the show page of that event
Then "move" should have options "todo, Chatter room"
	And 1 comments should exist
When I select "Chatter room" from "move"
	And I press "Go!"
Then I should be redirected to the show page of that event
	And I should not see "Fuck Christmas!"
	And 1 comments should exist
When I go to the todos page
	And I follow "Chatter room"
	And I should see "Fuck Christmas!"
	And a comment should exist with comment: "Fuck Christmas!<br />and his goat!"


Scenario: A comment cannot be blank (AJAX)
Given a user is logged in as "kurosawa"
	When I go to the show page of event "christmas"
	And I press "コメントを書き足す"
Then I should be redirected to the show page of that event
	And I should see "コメントは空白のままにしておく事は出来ません"

Scenario: Add a comment
Given a user is logged in as "reiko"
When I go to the show page of event "christmas"
	And I fill in "Comment*" with "Fuck Christmas!"
	And I press "コメントを書き足す"
Then I should see "Fuck Christmas!"
	And a comment exists with comment: "I wanna chat!", user: user "reiko", event: event "christmas", todo_id: "nil"

Scenario Outline: Edit & delete options for comments should be visible for respective role
Given a comment: "fuck_christmas" exists with comment: "Fuck Christmas!", user: user "aya", event: event "christmas"
	And a comment: "fuck_santa" exists with comment: "Fuck Santa!", user: user "kurosawa", event: event "christmas"
	And a comment: "fuck_goat" exists with comment: "And fuck his goat!", user: user "thomas", event: event "christmas"
	And a user is logged in as "<user>"
When I go to the show page of event "christmas"
Then I should <kurosawa> within comment "fuck_santa"
  And I should <aya> within comment "fuck_christmas"
  And I should <thomas> within comment "fuck_goat"
Examples:
| user      | aya                   		| kurosawa                       | thomas                       |
| kurosawa  | not see links "編集, 削除"  		| not see links "編集, 削除"  | not see links "編集, 削除"  |
| aya       | see links "Edit, Del"   		| see links "Edit, Del"       | see links "Edit, Del"       |
| thomas    | not see links "Edit, Del"   | not see links "Edit, Del"   |	see links "Edit, Del"       |

Scenario: Edit a comment
Given a comment exists with comment: "Fuck Christmas!", user: user "thomas", event: event "christmas"
	And a user is logged in as "thomas"
Then 1 comments should exist
When I go to the show page of event "christmas"
	And I follow "Edit" within that comment
	And I fill in "comment_comment" with ""
	And I press "Update"
Then I should be redirected to the error show page of that comment
	And I should see "Comment cannot be left blank."
	And I should see "Fuck Christmas!"
When I fill in "comment_comment" with "Fuck Santa's goat!"
	And I press "Update"
Then I should be redirected to the show page of its event
	And I should see "Fuck Santa's goat!"
	And 1 comments should exist

Scenario: Delete a comment
Given a comment exists with comment: "Fuck Christmas!", user: user "thomas", event: event "christmas"
	And a user is logged in as "thomas"
Then 1 comments should exist
When I go to the show page of event "christmas"
	And I follow "Del" within that comment
Then I should be redirected to the show page of its event
	And I should not see "Fuck Christmas!"
	And 0 comments should exist

Scenario: Delete with ajax (NOT IMPLEMENTED)
Given not implemented