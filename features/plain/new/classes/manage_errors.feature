@errors
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	
@course_errors
Scenario: Course errors
Given a course exists with name: "Ruby I", capacity: "8"
	And a user is logged in as "johan"
When I go to the new klass page
	And I select "" from "Course"
	And I press "Create"
Then I should be redirected to the error klasses page
	And I should see "can't be blank" as error message for klass course

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
| ０					|	can't be zero		|	should   		|

@capacity_errors_edit
Scenario: Capacity errors for a class in edit mode
Given a course exists with name: "Ruby I"
	And a klass exists with course: that course
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user is logged in as "aya"
When I go to the edit page of that klass
	And I fill in "Capacity" with ""
	And I press "Update"
Then I should be redirected to the error show page of that klass
	And I should see "is not a number" as error message for klass capacity

@capacity_ok
Scenario: Capacity can be told with japanese numbers
Given a user is logged in as "johan"
When I go to the new klass page
	And I fill in "Capacity" with "３"
	And I press "Create"
Then I should be redirected to the error klasses page
	And the "Capacity" field should contain "3"

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
|	1250	|	12:50		|
| 3:13	|	03:13		|
|	13		|	13:00		|
|	0			|	00:00		|
|	１３		|	13:00		|
|	８３０		|	08:30		|
|	１:0６	|	01:06		|
