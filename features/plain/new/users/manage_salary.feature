Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	
Scenario Outline: View salery
Given a user is logged in as "johan"
	And a course: "ruby" exists with name: "Ruby II"
	And a klass: "ruby0201" exists with course: course "ruby", date: "2010-02-01", start_time: "10:00", end_time: "12:00"
	And a klass: "ruby0228" exists with course: course "ruby", date: "2010-02-28", start_time: "10:00", end_time: "10:50"
	And a klass: "ruby0301" exists with course: course "ruby", date: "2010-03-01", start_time: "10:00", end_time: "12:00"
	And a klass: "ruby0331" exists with course: course "ruby", date: "2010-03-31", start_time: "10:00", end_time: "10:50"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan", cost: "1500"
	And a courses_teacher exists with course: course "ruby", teacher: user "aya", cost: "1300"
	And a teaching exists with klass: klass "ruby0201", teacher: user "johan"
	And a teaching exists with klass: klass "ruby0228", teacher: user "johan"
	And a teaching exists with klass: klass "ruby0301", teacher: user "aya"
	And a teaching exists with klass: klass "ruby0331", teacher: user "aya"
When I browse to the salary users page for "<month>"
Then "<month>" should be selected in the "Month" field
	And I should see "Salary" as title
	And I should see "Johan Sveholm" within "div.show"
	And I should <feb> "3000円 - 2/1(Monday) - Ruby II" within user "johan"
	And I should <feb> "1500円 - 2/28(Sunday) - Ruby II" within user "johan"
	And I should <feb> "4500円 (total)" within user "johan"
	And I should see "Aya Komatsu" within "div.show"
	And I should <mar> "2600円 - 3/1(Monday) - Ruby II" within user "aya"
	And I should <mar> "1300円 - 3/31(Wednesday) - Ruby II" within user "aya"
	And I should <mar> "3900円 (total)" within user "aya"
Examples:
|	month			|	feb			|	mar			|
|	February	|	see			|	not see	|
|	March			|	not see	|	see			|
	
Scenario: Make it work with not only month, but also year (NOT IMPLEMENTED)
Given not implemented

@allow-rescue
Scenario Outline: Only admins can see salary overview
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"
	And a user is logged in as "<user>"
Given I go to the salary users page
Then I should be redirected to the events page
Examples:
|	user		|
|	thomas	|
|	prince	|
|	junko		|
|	mika		|
|	reiko		|