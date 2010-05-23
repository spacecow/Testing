Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", cost: "2900"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu", cost: "1500"
	And a course: "rails" exists with name: "Rails II"
	And a course: "fortran" exists with name: "Fortran I"
	And a course: "ruby" exists with name: "Ruby III"

@view
Scenario: View of the teacher courses selection
Given a user is logged in as "aya"
When I browse to the teacher courses page for user "johan"
Then I should see "Enlisted Teacher Courses - Johan Sveholm" as title
	And the "Ruby III" checkbox should not be checked
  And the "Rails II" checkbox should not be checked
  And the "Fortran I" checkbox should not be checked
  And within "Ruby_III", the "円/h" field should contain "2900"
  And within "Rails_II", the "円/h" field should contain "2900"
  And within "Fortran_I", the "円/h" field should contain "2900"

@pending
Scenario: View the courses in mogi-order
#Given a courses_teacher exists with teacher: user "aya", course: course "rails", chosen: true, cost: "1400"
#	And a user is logged in as "aya"
#When I browse to the teacher courses page for user "aya"
#Then I should see courses "Ruby III, 1500, Rails II, 1400, Fortran I, 1500" within the form

@checked
Scenario: Courses already existing should be checked
Given a courses_teacher exists with teacher: user "aya", course: course "rails", chosen: true, cost: "1400"
	And a user is logged in as "aya"
When I browse to the teacher courses page for user "aya"
	And the "Ruby III" checkbox should not be checked
	And the "Rails II" checkbox should be checked
	And the "Fortran I" checkbox should not be checked

@select
Scenario: Select teacher courses
Given a user is logged in as "aya"
When I browse to the teacher courses page for user "aya"
	And I check "Ruby III"
	And I check "Fortran I"
	And I press "Update"
Then I should automatically browse to the teachers page
	And I should see "Successfully updated courses."
	And a courses_teacher should exist with course: course "ruby", teacher: user "aya", chosen: true
	And a courses_teacher should exist with course: course "fortran", teacher: user "aya", chosen: true
	And 2 courses_teachers should exist
	And 0 courses_students should exist

@deselect
Scenario: A deselected course should be deleted
Given a courses_teacher exists with teacher: user "aya", course: course "rails", chosen: true, cost: "1400"
	And a user is logged in as "aya"
When I browse to the teacher courses page for user "aya"
	And I uncheck "Rails II"
	And I check "Fortran I"
	And I press "Update"
Then a courses_teacher should exist with teacher: user "aya", course: course "fortran", chosen: true, cost: 1500
	And 1 courses_teachers should exist	

@deselect_with_error
Scenario: A deselected course should be deleted even if it has errors
Given a courses_teacher exists with teacher: user "aya", course: course "rails", chosen: true, cost: "1400"
	And a user is logged in as "aya"
When I browse to the teacher courses page for user "aya"
	And I uncheck "Rails II"
	And I within "Rails_II", fill in "円/h" with ""
	And I check "Fortran I"
	And I press "Update"
Then a courses_teacher should exist with teacher: user "aya", course: course "fortran", chosen: true, cost: 1500
	And 1 courses_teachers should exist	

@deselect_error_page
Scenario: A deselected course should not be displayed on the error page
Given a courses_teacher exists with teacher: user "aya", course: course "rails", chosen: true, cost: "1400"
	And a user is logged in as "aya"
When I browse to the teacher courses page for user "aya"
	And I uncheck "Rails II"
	And I check "Fortran I"
	And I within "Fortran_I", fill in "円/h" with ""
	And I press "Update"
Then I should be redirected to the error show page for user "aya"	
	And the "Ruby_III" id should not exist
	And the "Rails II" checkbox should not be checked
	And the "Fortran I" checkbox should be checked
	And within "Rails_II", the "円/h" field should contain "1400"
	And within "Fortran_I", the "円/h" field should contain ""
When I within "Fortran_I", fill in "円/h" with "2000"
	And I press "Update"
Then a courses_teacher should exist with teacher: user "aya", course: course "fortran", chosen: true, cost: 2000
	And 1 courses_teachers should exist	

Scenario: With no selection, no associations should be created
Given a user is logged in as "aya"
When I browse to the teacher courses page for user "johan"
	And I press "Update"
Then 0 courses_teachers should exist

Scenario Outline: If one just fills in the cost, the association is not saved
Given a user is logged in as "aya"
When I browse to the teacher courses page for user "johan"
	And I within "Ruby_III", fill in "円/h" with "<cost>"
	And I press "Update"
Then I should be redirected to the users page
	And I should see "Successfully updated courses."
	And 0 courses_teachers should exist
Examples:
|	cost	|
|				|
|	1500	|
|	get		|

@error
Scenario Outline: An association that is checked but does not have its cost filled in with a number will generate an error
Given a user is logged in as "aya"
When I browse to the teacher courses page for user "johan"
	And I check "Rails II"
	And I within "Rails_II", fill in "円/h" with "<cost>"
	And I press "Update"
Then I should be redirected to the error show page for user "johan"
	And I should see "is not a number"
When I within "Rails_II", fill in "円/h" with "1500"
	And I press "Update"
Then I should automatically browse to the teachers page
	And I should see "Successfully updated courses."	
	And a courses_teacher should exist with teacher: user "johan", course: course "rails", chosen: true, cost: 1500
	And 1 courses_teachers should exist
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
	And I check "Fortran I"
	And I within "Fortran_I", fill in "円/h" with "<cost>"
	And I press "Update"
Then I should automatically browse to the teachers page
	And I should see "Successfully updated courses."	
	And a courses_teacher should exist with teacher: user "johan", course: course "fortran", chosen: true, cost: 3500
	And 1 courses_teachers should exist
Examples:
|	cost	|
|	3500	|
|	3５0０	|
|	３５００	|