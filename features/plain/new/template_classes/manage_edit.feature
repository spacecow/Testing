Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Junko Sumii"
	
Scenario Outline: Only authorized users can edit a template class
Given a template class exists
	And a user is logged in as "aya"
When I go to the edit page of that template class
Then I should be redirected to the edit page of that template class
	And I should see links "Info, Del, List Template Classes" at the bottom of the page
Examples:
|	user	|
|	johan	|
|	aya		|

@return_day
Scenario: After editing a template class one should return to the same day
Given a template class exists with day: "tue"
	And a user is logged in as "johan"
When I go to the edit page of that template class
	And I press "Update"
Then "Tuesday" should be selected as day in the select menu

Scenario: Edit an existing template class
Given a course: "ruby" exists with name: "Ruby I"
	And a course: "rails" exists with name: "Rails II"
	And a classroom: "room1" exists with name: "1"
	And a classroom: "room2" exists with name: "2"
	And a template class exists with course: course "ruby", classroom: classroom "room1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
	And a user is logged in as "aya"
When I go to the edit page of that template class
Then I should see "Editing Template Class" within "legend"
	And the "Title" field should contain "A funny title"
	And the "Capacity" field should contain "8"
	And "Monday" should be selected in the "Day" box
	And the "Start time" field should contain "18:50"
	And the "End time" field should contain "20:50"
	And the "Inactive" checkbox should not be checked
	And the "Description" field should contain "A funny description"
	And the "Note" field should contain "A funny note"
When I fill in "Title" with "A funnier title"
	And I fill in "Description" with "A funnier description"
	And I fill in "Note" with "A funnier note"
	And I select "" from "Day"
	And I choose "Yes"
	And I press "Update"
Then I should be redirected to the error show page of that template class
	And the "Title" field should contain "A funnier title"
	And the "Capacity" field should contain "8"
	And "" should be selected in the "Day" box
	And the "Start time" field should contain "18:50"
	And the "End time" field should contain "20:50"
	And the "Inactive" checkbox should be checked
	And the "Description" field should contain "A funnier description"
	And the "Note" field should contain "A funnier note"
When I select "Tuesday" from "Day"
	And I fill in "Start time" with "12:00"
	And I fill in "End time" with "13:00"
	And I fill in "Capacity" with "6"
	And I press "Update"
Then I should be redirected to the template classes page
	And I should see "Successfully updated template class" as notice flash message
	And a template class should exist with course: course "ruby", classroom: classroom "room1", start_time: "12:00", end_time: "13:00", title: "A funnier title", capacity: 6, mail_sending: 0, inactive: true, description: "A funnier description", note: "A funnier note", day: "tue"
	And 1 template_classes should exist

Scenario: Links from edit page
Given a template class exists
	And a user is logged in as "aya"
	Then 1 template_classes should exist
When I go to the edit page of that template class
Then I should see links "Info, Del, List Template Classes" at the bottom of the page
When I follow "Info" at the bottom of the page
Then I should be redirected to the show page of that template class
When I go to the edit page of that template class
	And I follow "List Template Classes" at the bottom of the page
Then I should be redirected to the template classes page
When I go to the edit page of that template class
	And I follow "Del" at the bottom of the page
Then I should be redirected to the template classes page
	And 0 template_classes should exist

@allow-rescue
Scenario Outline: Not everyone can edit a template class
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant, student", language: "ja", name: "Akira Kurosawa"	
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"	
	And a template class exists
	And a user is logged in as "<user>"
When I go to the edit page of that template class
Then I should be redirected to the events page
Examples:
|	user			|
|	thomas		|
| prince		|
| junko			|
| kurosawa	|
| mika			|
|	reiko			|

@pending
Scenario: You should not be able to move a class in time and make it interfere with teacher/room opitons (NOT IMPLEMENTED)