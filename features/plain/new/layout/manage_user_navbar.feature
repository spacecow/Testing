Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher, student", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"

Scenario Outline: The user navigation bar for students
Given a user is logged in as "<user>"
Then I should see commands "Reserve, Edit Profile, Logout, Mail" in the user navigation bar
Examples:
|	user	|
|	junko	|
|	reiko	|

Scenario Outline: The user navigation bar for teachers
Given a user is logged in as "<user>"
Then I should see commands "Confirm, Edit Profile, Logout, Mail" in the user navigation bar
Examples:
|	user		|
|	aya			|
|	thomas	|
|	prince	|

Scenario: The user navigation bar for teachers & students
Given a user is logged in as "johan"
Then I should see commands "Confirm, Reserve, Edit Profile, Logout, Mail, Send Invitation" in the user navigation bar

Scenario: The user navigation bar for registrants
Given a user is logged in as "mika"
Then I should see commands "Edit Profile, Logout" in the user navigation bar

@teacher_links
Scenario: Links for teachers
Given a user is logged in as "prince"
When I follow "Confirm" in the user navigation bar
Then I should be redirected to the confirm page of user "prince"