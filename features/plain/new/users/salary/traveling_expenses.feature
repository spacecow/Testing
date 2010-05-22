Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", cost: "0"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", cost: "1400", traveling_expenses: "400"	
	And a course: "ruby" exists with name: "Ruby I"
	And a courses_teacher exists with course: course "ruby", teacher: user "prince"
	And a klass: "ruby" exists with course: course "ruby", date: "2010-01-01", start_time: "10:00", end_time: "11:00"
	And a user is logged in as "johan"
	
Scenario Outline: If a teacher has zero/nil/empty traveling expenses, the column should not be shown
Given a user: "zero_traveling_expenses" exists with username: "zero_traveling_expenses", role: "registrant, teacher", cost: "1400", traveling_expenses: "0"
	And a user: "nil_traveling_expenses" exists with username: "nil_traveling_expenses", role: "registrant, teacher", cost: "1400"
	And a user: "empty_traveling_expenses" exists with username: "empty_traveling_expenses", role: "registrant, teacher", cost: "1400", traveling_expenses: ""
	And a courses_teacher exists with course: course "ruby", teacher: user "<user>"
	And a teaching exists with klass: klass "ruby", teacher: user "<user>", status_mask: 9
When I browse to the salary users page for "January"
Then the "<user>" id should not exist for "td"
Examples:
|	user											|
|	zero_traveling_expenses		|
|	nil_traveling_expenses		|
|	empty_traveling_expenses	|

Scenario: If a teacher has traveling expenses it should be shown on the salary page and included in the total
Given a teaching exists with klass: klass "ruby", teacher: user "prince", status_mask: 9
When I browse to the salary users page for "January"
Then I should see "#prince" table
|	1400円	|	400円	|	1/1(fri)	|	Ruby I	|	10:00～11:00	|	O	|	Edit	|
|	1800円	|				|						|					|							|		|				|

Scenario: Travel expenses only counts once each day
Given a klass: "ruby2" exists with course: course "ruby", date: "2010-01-01", start_time: "11:00", end_time: "12:00"
	And a klass: "ruby3" exists with course: course "ruby", date: "2010-01-02", start_time: "11:00", end_time: "12:00"
	And a teaching exists with klass: klass "ruby", teacher: user "prince", status_mask: 9
	And a teaching exists with klass: klass "ruby2", teacher: user "prince", status_mask: 9
	And a teaching exists with klass: klass "ruby3", teacher: user "prince", status_mask: 9
When I browse to the salary users page for "January"
Then I should see "#prince" table
|	1400円	|	400円	|	1/1(fri)	|	Ruby I	|	10:00～11:00	|	O	|	Edit	|
|	1400円	|				|	1/1(fri)	|	Ruby I	|	11:00～12:00	|	O	|	Edit	|
|	1400円	|	400円	|	1/2(sat)	|	Ruby I	|	11:00～12:00	|	O	|	Edit	|
|	5000円	|				|						|					|							|		|				|

Scenario: If the class is not taught the travel expenses are not included in the total
Given a teaching exists with klass: klass "ruby", teacher: user "prince", status_mask: 33
When I browse to the salary users page for "January"
Then show me the page
Then I should see "#prince" table
|	1400円	|	400円	|	1/1(fri)	|	Ruby I	|	10:00～11:00	|	X	|	Edit	|
|	0円		|				|						|					|							|		|				|



























