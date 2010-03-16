Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a course: "rails" exists with name: "Rails II"
	And a course: "fortran" exists with name: "Fortran I"
	And a course: "ruby" exists with name: "Ruby III"

@view
Scenario: View of the teacher courses selection
Given a user is logged in as "aya"
When I browse to the teacher courses page for user "johan"
Then I should see courses "Ruby III, Rails II, Fortran" within the form

Scenario: With no selection, no associations should be created
Given a user is logged in as "aya"
When I browse to the teacher courses page for user "johan"
	And I press "Update"
Then 0 courses_teachers should exist

@error
Scenario Outline: An association that is checked but does not have its cost filled in with a number will generate an error
Given a user is logged in as "aya"
When I browse to the teacher courses page for user "johan"
	And I check course 1
	And I fill in the cost with "<cost>" for course 1
	And I press "Update"
Then I should be redirected to the error show page for user "johan"
	And I should see "is not a number" as error message for user courses_teachers_attributes_0_cost
#	And I should see courses "Rails II" within the form
#When I fill in the cost with "1500" for course 0
#	And I press "Update"
#Then I should be redirected to the users page
#	And I should see "Successfully updated courses"	
#	And a courses_teacher should exist with teacher: user "johan", course: course "rails", chosen: true, cost: 1500
#	And 1 courses_teachers should exist
Examples:
|	cost	|
|				|
|	get		|
|	5get	|
|	get6	|
|	5get6	|

@cost
Scenario Outline: Only the association that is checked and have its cost filled in should be saved
Given a user is logged in as "aya"
When I browse to the teacher courses page for user "johan"
	And I check course 2
	And I fill in the cost with "<cost>" for course 2
	And I press "Update"
Then I should be redirected to the users page
	And I should see "Successfully updated courses"	
Then a courses_teacher should exist with teacher: user "johan", course: course "fortran", chosen: true, cost: 3500
	And 1 courses_teachers should exist
Examples:
|	cost	|
|	3500	|
|	3５0０	|
|	３５００	|

Scenario Outline: If one just fills in the cost, the association is not saved
Given a user is logged in as "aya"
When I browse to the teacher courses page for user "johan"
	And I fill in the cost with "<cost>" for course 0
	And I press "Update"
Then I should be redirected to the users page
	And I should see "Successfully updated courses"
	And 0 courses_teachers should exist
Examples:
|	cost	|
|				|
|	1500	|
|	get		|

Scenario: Japanese digits should be allowed (NOT IMPLEMENTED)
Given not implemented

Scenario: Inherit cost from user (NOT IMPLEMENTED)
Given not implemented

Scenario: Sort courses according to mogi-order (NOT IMPLEMENTED)
Given not implemented

Scenario: Clean up with css (NOT IMPLEMENTED)
Given not implemented