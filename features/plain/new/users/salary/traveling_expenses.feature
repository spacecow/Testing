Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", cost: "0"
	And a course: "ruby" exists with name: "Ruby I"
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

@pending
Scenario: If a teacher has traveling expenses it should be shown on the salary page and included in the total
Given a user: "prince" exists with username: "prince", role: "registrant, teacher", cost: "1400", traveling_expenses: "400"
	And a courses_teacher exists with course: course "ruby", teacher: user "prince"
	And a teaching exists with klass: klass "ruby", teacher: user "prince", status_mask: 9
When I browse to the salary users page for "January"
Then I should see "#prince" table
|	1400円	|	400円	|	1/1(fri)	|	Ruby I	|	10:00～11:00	|	O	|	Edit	|
|	1800円	|				|						|					|							|		|				|

@pending
Scenario: Travel expenses only count once for each day teaching

@pending
Scenario: If the class is not taught the travel expenses are not included in the total

@pending
Scenario: included in the total