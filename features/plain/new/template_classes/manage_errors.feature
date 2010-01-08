Background:
Given a setting exist with name: "main"
	And a user exist with username: "johan", role: "admin", language: "en"
	
Scenario: Visual & Links
Given a course exists with name: "Ruby I"
	And a course exists with name: "Rails II"
	And a user exists with username: "kurosawa", name: "Akira Kurosawa", role: "teacher"
	And a classroom exists with name: "1"
	And a user is logged in as "johan"
When I go to the new template class page
Then I should see "New Template Class" within "legend"
	And the "Course" field should have options "BLANK, Ruby I, Rails II"
	And the "Classroom" field should have options "BLANK, 1"
	And the "Capacity" field should contain "8"
	And the "Day" field should have options "BLANK, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday"
	And I should see "Ex. 17:50" within "li#template_class_start_time_string_input"
	And I should see "Ex. 18:40" within "li#template_class_end_time_string_input"
	And the "Inactive" checkbox should not be checked
When I follow "Template Classes" within "div.links"
	Then I should be redirected to the template classes page
	
Scenario: Errors
Given a user is logged in as "johan"
When I go to the new template class page
	And I fill in "Capacity" with ""
	And I press "Create"
Then I should be redirected to the error template classes page
	And I should see "Course*can't be blank"
	And I should see "Capacity*can't be blank"
	And I should see "Day*MondayTuesdayWednesdayThursdayFridaySaturdaySundaycan't be blank"
	
Scenario: Change capacity automatically when changing between conversation/grammar (NOT IMPLEMENTED)
Given not implemented	