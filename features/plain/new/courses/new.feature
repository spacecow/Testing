Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"

Scenario Outline: New course page for admin
Given a user: "aya" exist with username: "aya", role: "teacher, admin", language: "en", name: "Aya Komatsu"
	And a user is logged in as "<user>"
When I go to the new course page
Then I should see links "List Courses" at the bottom of the page
Examples:
|	user	|
| johan	|
| aya		|	

@allow-rescue
Scenario Outline: Some users cannot reach the new course page
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"	
	And a user is logged in as "<user>"
When I go to the new course page
Then I should be redirected to the events page
Examples:
|	user		|
| prince	|
| junko		|
| mika		|
|	reiko		|

Scenario: View of the new course page
Given a user is logged in as "johan"
When I go to the new course page
Then the "Name" field should be empty
	And the "Level (ja)*" field should be empty
	And the "Level (en)*" field should be empty
	And the "Yes" checkbox should not be checked
	And the "No" checkbox should be checked
	And the "Description" field should be emtpy
	And the "Note" field should be emtpy

Scenario: Create a course
Given a user is logged in as "johan"
When I go to the new course page
	And I fill in "Name" with "Rails II"
	And I fill in "Level (ja)*" with "蝓ｺ譛ｬ"
	And I fill in "Level (en)*" with "basic"
	And I fill in "Capacity" with "5"
	And I fill in "Description" with "yeah!"
	And I fill in "Note" with "even more yeah!"
	And I press "Create"
Then a course should exist with name: "Rails II", inactive: false, description: "yeah!", note: "even more yeah!", level_en: "basic", level_ja: "蝓ｺ譛ｬ", capacity: "5"
	And 1 courses should exist
	And I should see "Successfully created Course." as notice flash message
