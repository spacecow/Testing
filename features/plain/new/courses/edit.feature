Background:
Given a setting exists with name: "main"
	And a course exists with name: "Ruby I", level_en: "basic", level_ja: "基本"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"

Scenario Outline: Edit course for admin
Given a user: "aya" exist with username: "aya", role: "teacher, admin", language: "en", name: "Aya Komatsu"
	And a user is logged in as "<user>"
When I go to the edit page for that course
Then I should see links "Info, List Courses, Del" at the bottom of the page
Examples:
|	user	|
| johan	|
| aya		|	

@allow-rescue
Scenario Outline: Some users cannot reach the edit course page
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"	
	And a user is logged in as "<user>"
When I go to the edit page of that course
Then I should be redirected to the events page
Examples:
|	user		|
| prince	|
| junko		|
| mika		|
|	reiko		|

Scenario: View of edit course page
Given a user is logged in as "johan"
When I go to the edit page for that course
Then the "Name" field should contain "Ruby I"
	And the "Yes" checkbox should not be checked
	And the "No" checkbox should be checked
	And the "Description" field should be emtpy
	And the "Note" field should be emtpy

Scenario: Edit a course
Given a user is logged in as "johan"
When I go to the edit page for that course
	And I fill in "Name" with "Rails II"
	And I choose "Yes"
	And I fill in "Description" with "yeah!"
	And I fill in "Note" with "even more yeah!"
	And I press "Create"
Then a course should exist with name: "Rails II", inactive: true, description: "yeah!", note: "even more yeah!", level_en: "basic", level_ja: "基本"
	And 1 courses should exist
	And I should see "Successfully updated Course." as notice flash message