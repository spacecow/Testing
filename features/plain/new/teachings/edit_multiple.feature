Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", cost: "1500"
	And a course: "ruby" exists with name: "Ruby I"
	And a klass: "ruby1" exists with course: course "ruby", date: "2010-01-01", start_time: "10:00", end_time: "11:00"
	And a klass: "ruby2" exists with course: course "ruby", date: "2010-01-02", start_time: "10:00", end_time: "11:00"
	And a klass: "ruby3" exists with course: course "ruby", date: "2010-01-03", start_time: "10:00", end_time: "11:00"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a teaching: "ruby1" exists with klass: klass "ruby1", teacher: user "johan", status_mask: 9
	And a teaching: "ruby2" exists with klass: klass "ruby2", teacher: user "johan", status_mask: 9
	And a teaching: "ruby3" exists with klass: klass "ruby3", teacher: user "johan", status_mask: 9
	And a user is logged in as "johan"
	
Scenario: If no teaching is selected, admin should be redirected back to the salary page
When I browse to the salary users page for "January"
	And I press "Multi Edit"
Then I should be redirected to the salary users page
	And I should see "Select at least one teaching in order to multi edit." as error flash message

Scenario: Go to the multiple teachings page
When I browse to the salary users page for "January"
	And I check "" within teaching "ruby1"
	And I check "" within teaching "ruby3"
	And I press "Multi Edit"
Then I should be redirected to the edit multiple teachings page

Scenario: Edit multiple teachings page
When I browse to the salary users page for "January"
	And I check "" within teaching "ruby1"
	And I check "" within teaching "ruby3"
	And I press "Multi Edit"
	And I fill in "Cost (yen/h)*" with "1000"
	And I press "Update"
Then I should be redirected to the salary users page
Then I should see "#johan" table
|	|	1000â~	|	1/1(fri)	|	Ruby I	|	10:00Å`11:00	|	O	|	Edit	|
|	|	1000â~	|	1/2(sat)	|	Ruby I	|	10:00Å`11:00	|	O	|	Edit	|
|	|	1000â~	|	1/3(sun)	|	Ruby I	|	10:00Å`11:00	|	O	|	Edit	|
|	|	3000â~	|						|					|							|		|				|

Scenario: Edit multiple teachings page with an emtpy field and nothing happens