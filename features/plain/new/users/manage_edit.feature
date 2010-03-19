Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"
	
Scenario Outline: Cost only appears for admins that edit teachers
Given a user is logged in as "<user>"
When I go to the edit page for user "<edit>"
Then I should see a field "Cost" for user
Examples:
|	user	|	edit		|
|	johan	|	johan		|
|	johan	|	aya			|
|	aya		|	thomas	|
|	aya		|	prince	|

Scenario Outline: Cost don't appear for admins that edit students
Given a user is logged in as "<user>"
When I go to the edit page for user "<edit>"
Then I should not see a field "Cost" for user
Examples:
|	user	|	edit		|
|	johan	|	junko		|
|	johan	|	mika		|
|	aya		|	reiko		|

Scenario Outline: Cost don't appear when a non-admin edits his own user
Given a user is logged in as "<user>"
When I go to the edit page for user "<edit>"
Then I should not see a field "Cost" for user
Examples:
|	user		|	edit		|
|	thomas	|	thomas	|
|	prince	|	prince	|
|	junko		|	junko		|
|	mika		|	mika		|
|	reiko		|	reiko		|

@allow-rescue
Scenario Outline: A non-admin cannot edit other users
Given a user is logged in as "<user>"
When I go to the edit page for user "<edit>"
Then I should be redirected to the events page
Examples:
|	user		|	edit		|
|	thomas	|	prince	|
|	prince	|	junko		|
|	junko		|	mika		|
|	mika		|	reiko		|
|	reiko		|	thomas	|
