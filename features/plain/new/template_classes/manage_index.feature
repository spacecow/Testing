@index
Background:
Given a setting exist with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user exists with username: "thomas", role: "observer", language: "en"
	And a course: "ruby" exists with name: "Ruby I"
	And a course: "rails" exists with name: "Rails II"
	And a classroom: "1" exists with name: "1"
	And a template class exists with course: course "ruby", classroom: classroom "1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
	And a template class exists with day: "tue", course: course "rails", start_time: "12:00", end_time: "13:00"

Scenario: List Template Classes according to day
Given a user is logged in as "johan"
When I go to the template classes page
	And I select "Monday" from "Choose a day:"
	And I press "Go!"
Then "Monday" should be selected in the "Choose a day:" box
	And I should see "Ruby I" within "table#Ruby tr td#course_name"
	And I should see "18:50~20:50" within "table#Ruby tr td#time_interval"
	And I should see "" within "table#Ruby tr td#unit"
	And I should see "1" within "table#Ruby tr td#classroom"
	And I should see "" within "table#Ruby tr td#teacher"
	And I should see /Info\s+Edit\s+Del/ within "table#Ruby tr td#links"
	And I should see  within "table#Ruby tr td#links"
	And I should not see "Rails"
When I select "Tuesday" from "Choose a day:"
	And I press "Go!"
	And I should see "Rails II" within "table#Rails tr td#course_name"
	And I should see "12:00~13:00" within "table#Rails tr td#time_interval"	
	And I should see "" within "table#Rails tr td#unit"
	And I should see "" within "table#Rails tr td#classroom"
	And I should see "" within "table#Rails tr td#teacher"
	And I should see /Info\s+Edit\s+Del/ within "table#Rails tr td#links"
	And I should not see "Ruby"

Scenario: List Template Classes for observer
Given a user is logged in as "thomas"
When I go to the template classes page
	And I select "Monday" from "Choose a day:"
	And I press "Go!"
Then I should see "Info" within "table#Ruby tr td#links"
	And I should not see "Edit" within "table#Ruby tr td#links"
	And I should not see "Del" within "table#Ruby tr td#links"

Scenario: Links from index page
Given a user is logged in as "johan"
When I go to the template classes page
	And I select "Monday" from "Choose a day"
	And I press "Go!"
	And I follow "Info" within "table#Ruby tr td#links"
Then I should be redirected to the show page of template class: "ruby"
When I go to the template classes page
	And I select "Monday" from "Choose a day"
	And I press "Go!"
	And I follow "Edit" within "table#Ruby tr td#links"
Then I should be redirected to the edit page of template class: "ruby"
When I go to the template classes page
	And I follow "New Template Class" within "div#list div#links"
Then I should be redirected to the new template class page

Scenario: Change selection of day to ajax code (NOT IMPLEMENTED)
Given not implemented