@index
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Junko Sumii"
	And a course: "ruby" exists with name: "Ruby II"
	And a course: "rails" exists with name: "Rails II"
	And a classroom: "1" exists with name: "1"
	And a template class: "ruby" exists with course: course "ruby", classroom: classroom "1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
	And a template class: "rails" exists with day: "tue", course: course "rails", start_time: "12:00", end_time: "13:00"

Scenario Outline: List Template Classes according to day
Given a user is logged in as "<user>"
When I go to the template classes page
	And I select "Monday" from "Choose a day:"
	And I press "Go!"
Then "Monday" should be selected in the "Choose a day:" box
	And I should see "II" within "table#Ruby tr td.course_level"
	And I should see "18:50~20:50" within "table#Ruby tr td#time_interval"
	And I should see "" within "table#Ruby tr td#unit"
	And I should see "1" within "table#Ruby tr td#classroom"
	And I should see "" within "table#Ruby tr td#teacher"
	And I should see options "Info, Edit, Del" within "table#Ruby tr td#links"
	And I should not see "Rails"
When I select "Tuesday" from "Choose a day:"
	And I press "Go!"
	And I should see "II" within "table#Rails tr td.course_level"
	And I should see "12:00~13:00" within "table#Rails tr td#time_interval"	
	And I should see "" within "table#Rails tr td#unit"
	And I should see "" within "table#Rails tr td#classroom"
	And I should see "" within "table#Rails tr td#teacher"
	And I should see /Info\s+Edit\s+Del/ within "table#Rails tr td#links"
	And I should not see "Ruby"
Examples:
|	user		|
|	johan		|
|	aya			|

Scenario: List Template Classes for observer
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user is logged in as "thomas"
When I go to the template classes page
	And I select "Monday" from "Choose a day:"
	And I press "Go!"
Then I should see "Info" within "table#Ruby tr td#links"
	And I should not see "Edit" within "table#Ruby tr td#links"
	And I should not see "Del" within "table#Ruby tr td#links"

@index_links
Scenario: Links from index page
Given a course: "ruby2" exists with name: "Ruby I"
	And a user is logged in as "aya"
When I go to the template classes page
Then 2 template_classes should exist
When I select "Monday" from "Choose a day"
	And I press "Go!"
	And I follow "Info" within "table#Ruby tr td#links"
Then I should be redirected to the show page of template class: "ruby"
When I go to the template classes page
	And I select "Monday" from "Choose a day"
	And I press "Go!"
	And I follow "Edit" within "table#Ruby tr td#links"
Then I should be redirected to the edit page of template class: "ruby"
When I go to the template classes page
	And I select "Monday" from "Choose a day"
	And I press "Go!"
	And I follow "New Template Class" within "div#list div#links"
Then I should be redirected to the new template class page
	And "Monday" should be selected in the "Day" box
	And the "Course" field should have options "BLANK, Ruby I, Ruby II, Rails II"
When I press "Create"
Then I should be redirected to the error template classes page
	And the "Course" field should have options "BLANK, Ruby I, Ruby II, Rails II"
When I press "Create"
Then I should be redirected to the error template classes page
	And the "Course" field should have options "BLANK, Ruby I, Ruby II, Rails II"	
When I go to the template classes page
	And I select "Monday" from "Choose a day"
	And I press "Go!"
	And I follow "+" within "table#Ruby"
Then I should be redirected to the new template class page
	And "Monday" should be selected in the "Day" box
	And the "Course" field should have options "BLANK, Ruby I, Ruby II"
When I press "Create"
Then I should be redirected to the error template classes page
	And the "Course" field should have options "BLANK, Ruby I, Ruby II"
When I press "Create"
Then I should be redirected to the error template classes page
	And the "Course" field should have options "BLANK, Ruby I, Ruby II"	
When I go to the template classes page
	And I select "Monday" from "Choose a day"
	And I press "Go!"
	And I follow "+" within template_class "ruby"
Then I should be redirected to the template classes page
	And I should see "Successfully created template class" as notice flash message
	And "Monday" should be selected in the "Choose a day" box
	And 3 template_classes should exist
	And 2 template_classes should exist with start_time: "18:50", end_time: "20:50", capacity: 8
When I follow "Del" within "table#Ruby tr td#links"
Then I should be redirected to the template classes page
	And I should see "Successfully deleted template class" as notice flash message
	And "Monday" should be selected in the "Choose a day" box
	And 2 template_classes should exist
	And 1 template_classes should exist with start_time: "18:50", end_time: "20:50", capacity: 8


@allow-rescue
Scenario Outline: Some users cannot reach this page
Given a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"	
	And a user is logged in as "<user>"
When I go to the template classes page
Then I should be redirected to the events page
Examples:
|	user			|
| prince		|
| junko			|
| mika			|
|	reiko			|

Scenario: Change selection of day to ajax code (NOT IMPLEMENTED)
Given not implemented

Scenario: A duplication of a class should duplicate all fields (NOT IMPLEMENTED)
Given not implemented