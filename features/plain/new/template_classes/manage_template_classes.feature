@manage
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Junko Sumii"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant, student", language: "ja", name: "Akira Kurosawa"	
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	
Scenario Outline: Create a new template class
Given a course: "ruby" exists with name: "Ruby I"
	And a course exists with name: "Rails II"
	And a classroom: "1" exists with name: "1"
	And a user is logged in as "<user>"
When I go to the new template class page
	And I fill in "Title" with "A funny title"
	And I select "Ruby I" from "Course"
	And I select "Monday" from "Day"
	And I select "1" from "Classroom"
	And I fill in "Description" with "A funny description"
	And I fill in "Note" with "A funny note"
	And I press "Create"
Then I should be redirected to the error template classes page
	And "Ruby I" should be selected in the "Course" box
	And "Monday" should be selected in the "Day" box
	And "1" should be selected in the "Classroom" box
When I fill in "Start time" with "18:50"
	And I fill in "End time" with "20:50"
	And I press "Create"
Then I should be redirected to the template classes page
	And I should see "Successfully created template class" within "#notice"
	And a template class should exist with course: course "ruby", classroom: classroom "1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
	And I should have 1 template classes
Examples:
|	user	|
|	johan	|
|	aya		|

Scenario Outline: Not everyone can create a template class
Given a user is logged in as "<user>"
When I go to the new template class page
Then I should be redirected to the events page
Examples:
|	user			|
|	thomas		|
| prince		|
| junko			|
| mika			|

Scenario Outline: Edit an existing template class
Given a course: "ruby" exists with name: "Ruby I"
	And a course: "rails" exists with name: "Rails II"
	And a classroom: "room1" exists with name: "1"
	And a classroom: "room2" exists with name: "2"
Given a template class exists with course: course "ruby", classroom: classroom "room1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
	And a user is logged in as "<user>"
When I go to the edit page of that template class
Then I should see "Editing Template Class" within "legend"
	And the "Title" field should contain "A funny title"
	And "Ruby I" should be selected in the "Course" box
	And "1" should be selected in the "Classroom" box
	And the "Capacity" field should contain "8"
	And "Monday" should be selected in the "Day" box
	And the "Start time" field should contain "18:50"
	And the "End time" field should contain "20:50"
	And the "Mail Sending" field should contain "0"
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
	And "Ruby I" should be selected in the "Course" box
	And "1" should be selected in the "Classroom" box
	And the "Capacity" field should contain "8"
	And "" should be selected in the "Day" box
	And the "Start time" field should contain "18:50"
	And the "End time" field should contain "20:50"
	And the "Mail Sending" field should contain "0"
	And the "Inactive" checkbox should be checked
	And the "Description" field should contain "A funnier description"
	And the "Note" field should contain "A funnier note"
When I select "Tuesday" from "Day"
	And I select "Rails II" from "Course"
	And I select "2" from "Classroom"
	And I fill in "Start time" with "12:00"
	And I fill in "End time" with "13:00"
	And I fill in "Capacity" with "6"
	And I fill in "Mail Sending" with "2"
	And I press "Update"
Then I should be redirected to the template classes page
	And I should see "Successfully updated template class" within "#notice"
	And a template class should exist with course: course "rails", classroom: classroom "room2", start_time: "12:00", end_time: "13:00", title: "A funnier title", capacity: 6, mail_sending: 2, inactive: true, description: "A funnier description", note: "A funnier note", day: "tue"
	And I should have 1 template classes
When I go to the edit page of that template class
Then I should see options "Info, List Template Classes" within "div#links"
	And I follow "Info" within "div#links"
	Then I should be redirected to the show page of that template class
When I go to the edit page of that template class
	And I follow "List Template Classes" within "div#links"
Then I should be redirected to the template classes page	
Examples:
|	user	|
|	johan	|
|	aya		|
	
Scenario Outline: Not everyone can edit a template class
Given a course: "ruby" exists with name: "Ruby I"
	And a classroom: "room1" exists with name: "1"
	And a template class exists with course: course "ruby", classroom: classroom "room1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "mon"
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

Scenario: Include teacher in edit form (NOT IMPLEMENTED)
Given not implemented

Scenario: Delete a template class (NOT IMPLEMENTED)
Given not implemented
#Given I should have 2 template classes
#When I follow 'delete' within "template_klass_1"
#Then I should be redirected to the list of template classes
#	And I should have 1 template class
#When I follow 'delete' within "template_klass_2"
#Then I should be redirected to the list of template classes
#	And I should have 0 template classes	
#
#And a template class should exist with course: course "ruby", classroom: classroom "1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "Mon"

Scenario: Sort courses in order in the drop-box (NOT IMPLEMENTED)
Given not implemented