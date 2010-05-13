Background:
Given a setting exists with name: "main"
	And a course exists with name: "Ruby I"

Scenario: List Classes for observer
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user is logged in as "thomas"
When I go to the courses page
Then I should see options "Info" within "table tr td#links"
	And I should see links "New Course" at the bottom of the page

@allow-rescue
Scenario Outline: Some users cannot reach this page
Given a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"	
	And a user is logged in as "<user>"
When I go to the courses page
Then I should be redirected to the events page
Examples:
|	user			|
| prince		|
| junko			|
| mika			|
|	reiko			|