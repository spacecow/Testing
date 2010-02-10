Background:
Given a setting exist with name: "main"
	And a course: "ruby" exists with name: "Ruby I"
	And a klass exists with date: "2012-3-28", course: course "ruby", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, cancel: false, description: "A funny description", note: "A funny note"
	And a user exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"

Scenario: Edit an existing template class
Given a user is logged in as "johan"
When I go to the edit page of that klass
Then I should see "Editing Class" within "legend"
	And there should be no "Course" field
	And there should be no "Date" field
	And the "Start time" field should contain "18:50"
	And the "End time" field should contain "20:50"
	And the "Cancel" checkbox should not be checked
	And the "Capacity" field should contain "8"
	And the "Title" field should contain "A funny title"
	And the "Description" field should contain "A funny description"
	And the "Note" field should contain "A funny note"
When I fill in "Title" with "A funnier title"
	And I fill in "Description" with "A funnier description"
	And I fill in "Note" with "A funnier note"
	And I fill in "Capacity" with "0"
	And I choose "Yes"
	And I press "Update"
Then I should be redirected to the error show page of that klass
	And there should be no "Course" field
	And there should be no "Date" field
	And the "Start time" field should contain "18:50"
	And the "End time" field should contain "20:50"
	And the "Cancel" checkbox should be checked
	And the "Capacity" field should contain "0"
	And the "Title" field should contain "A funnier title"
	And the "Description" field should contain "A funnier description"
	And the "Note" field should contain "A funnier note"
When I fill in "Capacity" with "6"
	And I fill in "Start time" with "12:00"
	And I fill in "End time" with "13:00"
	And I press "Update"
Then I should be redirected to the klasses page
	And I should see "Successfully updated Class" as notice flash message
	And a klass should exist with date: "2012-3-28", course: course "ruby", start_time: "12:00", end_time: "13:00", title: "A funnier title", capacity: 6, cancel: true, description: "A funnier description", note: "A funnier note"
	And 1 klasses should exist

@allow-rescue
Scenario Outline: Not everyone can edit a class
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant, student", language: "ja", name: "Akira Kurosawa"	
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user is logged in as "<user>"
When I go to the edit page of that klass
Then I should be redirected to the events page
Examples:
|	user			|
|	thomas		|
| prince		|
| junko			|
| mika			|

Scenario Outline: Only authorized users can reach the edit page of a class
Given a user is logged in as "<user>"
When I go to the edit page of that klass
Then I should be redirected to the edit page of that klass
Examples:
|	user	|
|	johan	|
| aya		|

@edit_links
Scenario: Links for authorized users on the edit page of a class
Given a user is logged in as "aya"
When I go to the edit page of that klass
Then I should see links "Info, Del, List Classes" at the bottom of the page
When I follow "Info" at the bottom of the page
Then I should be redirected to the show page of that klass
When I go to the edit page of that klass
	And I follow "List Classes" at the bottom of the page
Then I should be redirected to the klasses page 
	And "March" should be selected in "class_month"
 	And "28" should be selected in "class_day"
 	And "2012" should be selected in "class_year"
When I go to the edit page of that klass
	And I follow "Del" at the bottom of the page
Then I should be redirected to the klasses page
	And "March" should be selected in "class_month"
 	And "28" should be selected in "class_day"
 	And "2012" should be selected in "class_year"
	And I should see "Successfully deleted Class" as notice flash message
	And 0 klasses should exist