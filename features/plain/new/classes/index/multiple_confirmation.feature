@index
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "teacher, admin", language: "en", name: "Aya Komatsu"
	And a course exists with name: "Ruby I"
	And a klass: "1" exists with todays date with course: that course
	And a klass: "2" exists with todays date with course: that course
	And a courses_teacher exists with course: that course, teacher: user "johan"
	And a courses_teacher exists with course: that course, teacher: user "aya"
	And a user is logged in as "johan"
	
Scenario: If all teachers are unconfirmed, an option to confirm all teachers at the same time should be available
Given a teaching exists with klass: klass "1", teacher: user "johan", status_mask: 4
	And a teaching exists with klass: klass "2", teacher: user "aya", status_mask: 4
When I go to the klasses page
Then I should see a multiple confirm button labeled "?"
	And I should see no multiple teach button
	
Scenario: If all teachers are confirmed, an option to decline all teachers at the same time should be available
Given a teaching exists with klass: klass "1", teacher: user "johan", status_mask: 33
	And a teaching exists with klass: klass "2", teacher: user "aya", status_mask: 33
When I go to the klasses page
Then I should see a multiple confirm button labeled "O"
	And I should see a multiple teach button labeled "?"
	
Scenario: If all teachers are declined, an option to unconfirm all teachers at the same time should be available
Given a teaching exists with klass: klass "1", teacher: user "johan", status_mask: 2
	And a teaching exists with klass: klass "2", teacher: user "aya", status_mask: 2
When I go to the klasses page
Then I should see a multiple confirm button labeled "X"
	And I should see no multiple teach button

Scenario Outline: If not all teachers have the same confirmation status, a multiple confirmation button is not to be seen
Given a teaching exists with klass: klass "1", teacher: user "johan", status_mask: <status>
When I go to the klasses page
Then I should see no multiple confirm button
Examples:
|	status	|
|	4				|
|	33			|
|	2				|

Scenario Outline: Multiple confirm
Given a teaching exists with klass: klass "1", teacher: user "johan", status_mask: <status1> 
	And a teaching exists with klass: klass "2", teacher: user "aya", status_mask: <status1>
When I go to the klasses page
	And I press the multiple confirm button
Then a teaching should exist with klass: klass "1", teacher: user "johan", status_mask: <status2>
	And a teaching should exist with klass: klass "2", teacher: user "aya", status_mask: <status2>
	And 2 teachings should exist
Examples:
|	status1	|	status2	|
|	4				|	33			|
|	33			|	2				|
|	2				|	4				|