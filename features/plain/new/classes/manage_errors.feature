@errors
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	
@course_errors
Scenario: Course errors
Given a course exists with name: "Ruby I"
	And a user is logged in as "johan"
When I go to the new klass page
	And I select "" from "Course"
	And I press "Create"
Then I should be redirected to the error klasses page
	And I should see "Course*Ruby Ican't be blank"

@capacity_errors
Scenario Outline: Capacity errors　旭蟹　red frog crab
Given a user is logged in as "johan"
When I go to the new klass page
And I fill in "Capacity" with "<input>"
	And I press "Create"
Then I should be redirected to the error klasses page
	And I should see "Capacity*<error>"
	And I <zero> see "can't be zero" within "li#klass_capacity_input"
Examples:
|	input			|	error						|	zero				|
| 					|	is not a number	|	should not	|
| asahigani	|	is not a number	|	should not	|
| 0					|	can't be zero		|	should   		|

@time_errors
Scenario Outline: Time errors　磯蟹　beach crab
Given a user is logged in as "johan"
When I go to the new klass page
	And I fill in "Start time" with "<input>"
	And I fill in "End time" with "<input>"
	And I press "Create"
Then I should be redirected to the error klasses page
	And I should see "can't be blank" within "li#klass_start_time_string_input"
	And I should see "can't be blank" within "li#klass_end_time_string_input"
Examples:
|	input		|
| 				|
|	isogani	|
|	b13			|
|	b13f		|
|	13d			|
|	-3			|
|	24			|

@time_ok
Scenario Outline: Time ok
Given a user is logged in as "johan"
When I go to the new klass page
	And I fill in "Start time" with "<input>"
	And I fill in "End time" with "<input>"
	And I press "Create"
Then I should be redirected to the error klasses page
	And the "Start time" field should contain "<output>"		
	And the "End time" field should contain "<output>"		
Examples:
|	input	|	output	|	
| 3:13	|	03:13		|
|	13		|	13:00		|
|	0			|	00:00		|