@errors
Background:
Given a setting exist with name: "main"
	And a user exist with username: "johan", role: "admin", language: "en"
	
Scenario: Visual & Links
Given a course exists with name: "Ruby I"
	And a course exists with name: "Ruby II"
	And a course exists with name: "Rails II"
	And a user exists with username: "kurosawa", name: "Akira Kurosawa", role: "teacher"
	And a user is logged in as "johan"
When I go to the new template class page
Then I should see "New Template Class" within "legend"
	And the "Course" field should have options "BLANK, Ruby I, Ruby II, Rails II"
	And the "Capacity" field should contain "0"
	And the "Day" field should have options "BLANK, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday"
	And I should see "Ex. 17:50" within "li#template_class_start_time_string_input"
	And I should see "Ex. 18:40" within "li#template_class_end_time_string_input"
	And the "Inactive" checkbox should not be checked
When I follow "List Template Classes" within "div#links"
	Then I should be redirected to the template classes page
	
@course_errors
Scenario: Course errors for template class
Given a course exists with name: "Ruby I"
	And a user is logged in as "johan"
When I go to the new template class page
	And I select "" from "Course"
	And I press "Create"
Then I should be redirected to the error template classes page
	And I should see "can't be blank" as error message for template_class course

@capacity_errors
Scenario Outline: Capacity errors for template class
Given a user is logged in as "johan"
When I go to the new template class page
	And I fill in "Capacity" with "<input>"
	And I press "Create"
Then I should be redirected to the error template classes page
	And I should see "<error>" as error message for template_class capacity
Examples:
|	input			|	error						|	zero				|
| 					|	is not a number	|	should not	|
| asahigani	|	is not a number	|	should not	|
| ０					|	can't be zero		|	should   		|
	
@capacity_errors_edit
Scenario: Capacity errors for a template class in edit mode
Given a course exists with name: "Ruby I"
	And a template class exists with course: that course
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user is logged in as "aya"
When I go to the edit page of that template class
	And I fill in "Capacity" with ""
	And I press "Update"
Then I should be redirected to the error show page of that template class
	And I should see "is not a number" as error message for template_class capacity

@capacity_ok
Scenario: Capacity can be told with japanese numbers
Given a user is logged in as "johan"
When I go to the new template class page
	And I fill in "Capacity" with "３"
	And I press "Create"
Then I should be redirected to the error template classes page
	And the "Capacity" field should contain "3"

@time_errors
Scenario Outline: Time errors for template class
Given a user is logged in as "johan"
When I go to the new template class page
	And I fill in "Start time" with "<input>"
	And I fill in "End time" with "<input>"
	And I press "Create"
Then I should be redirected to the error template classes page
	And I should see "can't be blank" as error message for template_class start_time_string
	And I should see "can't be blank" as error message for template_class end_time_string
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
When I go to the new template class page
	And I fill in "Start time" with "<input>"
	And I fill in "End time" with "<input>"
	And I press "Create"
Then I should be redirected to the error template classes page
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