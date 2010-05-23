@errors
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user is logged in as "johan"
	When I go to the new course page

Scenario: Japanese space should be turned into a European for name
When I fill in "Name" with "韓国語　初級"
	And I press "Create"
Then I should be redirected to the error courses page
	And the "Name" field should contain "韓国語 初級"
	
@capacity_errors
Scenario Outline: Capacity errors for course
Given a course exists
When I go to the <path>
	And I fill in "Capacity" with "<input>"
	And I press "<button>"
Then I should see "<error>" as error message for course capacity
Examples:
|	path											|	input			|	button	|	error						|
|	new course page						| 					|	Create	|	is not a number	|
|	new course page						| asahigani	|	Create	|	is not a number	|
|	new course page						| ０					|	Create	|	can't be zero		|
|	edit page of that course	| 					|	Update	|	is not a number	|
|	edit page of that course	| asahigani	|	Update	|	is not a number	|
|	edit page of that course	| ０					|	Update	|	can't be zero		|

@capacity_ok
Scenario: Capacity can be told with japanese numbers
When I go to the new course page
	And I fill in "Capacity" with "３"
	And I press "Create"
Then the "Capacity" field should contain "3"