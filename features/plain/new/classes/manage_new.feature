@new
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"

#Scenario Outline: Create a new template class
#Given a course: "ruby" exists with name: "Ruby I"
#	And a course exists with name: "Rails II"
#	And a user is logged in as "<user>"
#When I go to the new template class page
#Then the "Capacity" field should contain "0"
#When I fill in "Title" with "A funny title"
#	And I select "Ruby I" from "Course"
#	And I select "Monday" from "Day"
#	And I fill in "Description" with "A funny description"
#	And I fill in "Note" with "A funny note"
#	And I press "Create"
#Then I should be redirected to the error template classes page
#	And "Ruby I" should be selected in the "Course" box
#	And "Monday" should be selected in the "Day" box
#When I fill in "Start time" with "18:50"
#	And I fill in "End time" with "20:50"
#	And I press "Create"
#Then I should be redirected to the template classes page
#	And I should see "Successfully created template class" within "#notice"
#	And a template class should exist with course: course "ruby", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 0, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
#	And I should have 1 template classes

#Scenario: Visual & Links
#Given a course exists with name: "Ruby I"
#	And a course exists with name: "Ruby II"
#	And a course exists with name: "Rails II"
#	And a user exists with username: "kurosawa", name: "Akira Kurosawa", role: "teacher"
#	And a user is logged in as "johan"
#When I go to the new template class page
#Then I should see "New Template Class" within "legend"
#	And the "Course" field should have options "BLANK, Ruby I, Ruby II, Rails II"
#	And the "Capacity" field should contain "0"
#	And the "Day" field should have options "BLANK, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday"
#	And I should see "Ex. 17:50" within "li#template_class_start_time_string_input"
#	And I should see "Ex. 18:40" within "li#template_class_end_time_string_input"
#	And the "Inactive" checkbox should not be checked
#When I follow "List Template Classes" within "div#links"
#	Then I should be redirected to the template classes page
#	
#Scenario: Errors
#Given a user is logged in as "johan"
#When I go to the new template class page
#	And I fill in "Capacity" with ""
#	And I press "Create"
#Then I should be redirected to the error template classes page
#	And I should see "Course*can't be blank"
#	And I should see "Capacity*can't be blank"
#	And I should see "Day*MondayTuesdayWednesdayThursdayFridaySaturdaySundaycan't be blank"

@new_view
Scenario: New view
Given a user is logged in as "johan"
When I go to the new klass page
Then "" should be selected in "klass_date_1i"
	And "" should be selected in "klass_date_2i"
	And "" should be selected in "klass_date_3i"

@capacity_errors
Scenario Outline: Capacity errorsÅ@àÆäIÅ@red frog crab
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
Scenario Outline: Time errorsÅ@àÈäIÅ@beach crab
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



@new_class
Scenario: Create a new class
Given a user is logged in as "johan"
	And a course exists with name: "Ruby I"
	And a course exists with name: "Rails II"
	And a course exists with name: "Fortran I"
When I go to the new klass page
Then I should see "New Class" within "legend"
	And the "Course" field should have options "BLANK, Ruby I, Rails II, Fortran I"
	And 3 courses should exist
	And 0 klasses should exist
	And I should see "Ex. 17:50" within "li#klass_start_time_string_input"
	And I should see "Ex. 18:40" within "li#klass_end_time_string_input"
	And the "Cancel" checkbox should not be checked
	And the "Capacity" field should contain "0"
	And "28" should be selected in "klass_date_3i"
#When I fill in "Capacity" with ""
#	And I press "Create"
#Then I should be redirected to the error klasses page
#	And the "Course" field should have options "BLANK, Ruby I, Rails II, Fortran I"
#	And 0 klasses should exist
#	And the "Cancel" checkbox should not be checked
#	And the "Capacity" field should contain "asahigani"	
#	And I should see "Course*Ruby IRails IIFortran Ican't be blank"
#	And I should see "can't be blank" within "li#klass_date_input ul.errors li"
#	And I should see "can't be blank" within "li#klass_start_time_string_input ul.errors"
#	And I should see "can't be blank" within "li#klass_end_time_string_input ul.errors"
#	And I should see "Capacity*can't be blank"	
#When I fill in "Capacity" with "asahigani"
#	And I press "Create"
#Then I should be redirected to the error klasses page
#	And I should see "Capacity*is not a number"
#When I fill in "Capacity" with "0"
#	And I press "Create"
#	
#When I fill in 'start_time' with "13:00"
#	And I fill in 'end_time' with "15:00"
#	
#Then I should have 2 classes
#	And I should see "Course "'activerecord.errors.messages.blank'
#	And I should not see "Start time "'activerecord.errors.messages.blank'
#	And I should not see "End time "'activerecord.errors.messages.blank'	
#When I select "Fortran I" from 'course'
#	And I press 'create'
#Then I should see 'klasses.listing'
#	And I should see "Fortran"'blank''course'
#	And I should see "13:00~15:00"
#	And I should have 3 classes
#Examples:
#|	user	|
#|	johan	|
#|	aya		|
	
Scenario Outline: Not everyone can create a template class
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user is logged in as "<user>"
When I go to the new klass page
Then I should be redirected to the events page
Examples:
|	user			|
|	thomas		|
| prince		|
| junko			|
| mika			|

Scenario Outline: Links from new page
Given a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Junko Sumii"
	And a user is logged in as "<user>"
When I go to the new klass page
Then I should see options "List Classes" within "div#links"
When I follow "List Classes" within "div#links"
Then I should be redirected to the klasses page
Examples:
|	user	|
|	johan	|
|	aya		|

Scenario: Fix date input (NOT IMPLEMENTED)
Given not implemented

Scenario: Date should be filled in automatically (NOT IMPLEMENTED)
Given not implemented

Scenario: Date should not include blank (NOT IMPLEMENTED)
Given not implemented

Scenario: Required fields and non-required fields (NOT IMPLEMENTED)
Given not implemented