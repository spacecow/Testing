Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	
@view
Scenario Outline: View
Given a user is logged in as "johan"
When I browse to the salary users page for "<month>"
Then "<month>" should be selected in the "Month" field
	And I should see "Salary" as title
Examples:
|	month			|
|	August		|
|	December	|
	
Scenario Outline: Check listing of salary for each month
Given a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a course: "ruby" exists
	And a klass: "ruby0101" exists with course: course "ruby", date: "2010-01-01"
	And a klass: "ruby0131" exists with course: course "ruby", date: "2010-01-31"
	And a klass: "ruby0201" exists with course: course "ruby", date: "2010-02-01"
	And a klass: "ruby0228" exists with course: course "ruby", date: "2010-02-28"
	And a klass: "ruby0301" exists with course: course "ruby", date: "2010-03-01"
	And a klass: "ruby0331" exists with course: course "ruby", date: "2010-03-31"
	And a courses_teacher exists with course: course "ruby", teacher: user "prince"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a courses_teacher exists with course: course "ruby", teacher: user "aya"
	And a teaching exists with klass: klass "ruby0101", teacher: user "prince", status_mask: 9
	And a teaching exists with klass: klass "ruby0131", teacher: user "prince", status_mask: 9
	And a teaching exists with klass: klass "ruby0201", teacher: user "johan", status_mask: 9
	And a teaching exists with klass: klass "ruby0228", teacher: user "johan", status_mask: 9
	And a teaching exists with klass: klass "ruby0301", teacher: user "aya", status_mask: 9
	And a teaching exists with klass: klass "ruby0331", teacher: user "aya", status_mask: 9
	And a user is logged in as "johan"
When I browse to the salary users page for "<month>"
	And I should see "Prince Philip" within "div.show"
	And I should <jan> "1/1(Friday)" within user "prince"
	And I should <jan> "1/31(Sunday)" within user "prince"
	And I should see "Johan Sveholm" within "div.show"
	And I should <feb> "2/1(Monday)" within user "johan"
	And I should <feb> "2/28(Sunday)" within user "johan"
	And I should see "Aya Komatsu" within "div.show"
	And I should <mar> "3/1(Monday)" within user "aya"
	And I should <mar> "3/31(Wednesday)" within user "aya"
Examples:
|	month			|	jan			|	feb			|	mar			|
|	January		|	see			|	not see	|	not see	|
|	February	|	not see	|	see			|	not see	|
|	March			|	not see	|	not see	|	see			|
	
Scenario: The total salary for a class is the hour salary times no of hours
Given a course: "ruby" exists
	And a klass: "ruby0101" exists with course: course "ruby", date: "2010-01-01", start_time: "10:00", end_time: "11:00"
	And a klass: "ruby0114" exists with course: course "ruby", date: "2010-01-14", start_time: "10:00", end_time: "12:00"
	And a klass: "ruby0131" exists with course: course "ruby", date: "2010-01-31", start_time: "10:00", end_time: "13:00"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan", cost: "1400"
	And a teaching exists with klass: klass "ruby0101", teacher: user "johan", status_mask: 9
	And a teaching exists with klass: klass "ruby0114", teacher: user "johan", status_mask: 9
	And a teaching exists with klass: klass "ruby0131", teacher: user "johan", status_mask: 9
	And a user is logged in as "johan"
When I browse to the salary users page for "January"
Then I should see "1400円 - 1/1(Friday)" within user "johan"
	And I should see "2800円 - 1/14(Thursday)" within user "johan"
	And I should see "4200円 - 1/31(Sunday)" within user "johan"
	And I should see "8400円 (total)" within user "johan"

Scenario Outline: Salary does not carry on to the next month (NOT IMPLEMENTED)
Given a course: "ruby" exists
	And a klass: "ruby0901" exists with course: course "ruby", date: "2010-09-01"
	And a klass: "ruby1001" exists with course: course "ruby", date: "2010-10-01"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a teaching exists with klass: klass "ruby0901", teacher: user "johan", status_mask: 9, cost: "1500"
	And a teaching exists with klass: klass "ruby1001", teacher: user "johan", status_mask: 9, cost: "2000"
	And a user is logged in as "johan"
When I browse to the salary users page for "<month>"
Then I should see "<money>円 (total)" within user "johan"
Examples:
|	month			|	money	|
|	September	|	1500	|
|	October		|	2000	|

Scenario: View salary for different status of teaching
Given a course: "ruby" exists with name: "Ruby II"
	And a klass: "ruby0301" exists with course: course "ruby", date: "2010-03-01"
	And a klass: "ruby0302" exists with course: course "ruby", date: "2010-03-02", start_time: "10:00", end_time: "12:00"
	And a klass: "ruby0303" exists with course: course "ruby", date: "2010-03-03"
	And a klass: "ruby0304" exists with course: course "ruby", date: "2010-03-04", start_time: "10:00", end_time: "12:00"
	And a klass: "ruby0305" exists with course: course "ruby", date: "2010-03-05"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a teaching exists with klass: klass "ruby0301", teacher: user "johan", status_mask: 4
	And a teaching exists with klass: klass "ruby0302", teacher: user "johan", status_mask: 33
	And a teaching exists with klass: klass "ruby0303", teacher: user "johan", status_mask: 2
	And a teaching exists with klass: klass "ruby0304", teacher: user "johan", status_mask: 9
	And a teaching exists with klass: klass "ruby0305", teacher: user "johan", status_mask: 17
	And a user is logged in as "johan"
When I browse to the salary users page for "March"
Then I should not see "3/1(Monday)" within user "johan"
	And I should see "3/2(Tuesday) - Ruby II - 10:00~12:00 (not confirmed)" within user "johan"
	And I should not see "3/3(Wednesday)" within user "johan"
	And I should not see "3/4(Thursday) - Ruby II - 10:00~12:00 (not confirmed)" within user "johan"
	And I should see "3/4(Thursday) - Ruby II - 10:00~12:00" within user "johan"
	And I should not see "3/5(Friday)" within user "johan"

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

Scenario: Be able to individually change the cost for a teaching (NOT IMPLEMENTED)
Given not implemented