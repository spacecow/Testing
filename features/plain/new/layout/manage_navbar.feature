Background:
Given a setting exist with name: "main"
	
Scenario Outline: Links in the navigation bar for admins and look-alikes
Given a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user is logged in as "<user>"
When I follow "Events" in the navigation bar
Then I should be redirected to the events page
When I follow "Classes" in the navigation bar
Then I should be redirected to the klasses page
When I follow "Template Classes" in the navigation bar
Then I should be redirected to the template classes page
Examples:
|	user		|
|	johan		|
|	aya			|
|	thomas	|

Scenario Outline: Links in the navigation bar for students and teachers
Given a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"	
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"
	And a user is logged in as "<user>"
When I follow "Events" in the navigation bar
Then I should be redirected to the events page
When I follow "Classes" in the navigation bar
Then I should be redirected to the klasses page
Then I should not see "Template Classes" in the navigation bar
Examples:
|	user		|
|	prince	|
|	junko		|
|	reiko		|

Scenario: Links in the navigation bar for only registrants
And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
Given a user is logged in as "mika"
When I follow "Events" in the navigation bar
Then I should be redirected to the events page
	And I should not see "Classes" in the navigation bar
	And I should not see "Template Classes" in the navigation bar