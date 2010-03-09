Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a course: "rails" exists with name: "Rails II"
	And a course: "fortran" exists with name: "Fortran I"
	And a course: "ruby" exists with name: "Ruby III"

@view
Scenario: View of a user's courses page
Given a user is logged in as "aya"
When I browse to the teachers page
	And I follow "Courses" within user "johan"
Then I should see "Enlisted Courses" as title
	And I should see "Ruby III Rails II Fortran I"
	And the "Ruby III" checkbox should not be checked
  And the "Rails II" checkbox should not be checked
  And the "Fortran I" checkbox should not be checked

Scenario: Select student courses
Given a user: "reiko" exist with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"
	And a user is logged in as "aya"
When I browse to the students page
	And I follow "Courses" within user "reiko"
	And I check "Ruby III"
	And I check "Fortran I"
	And I press "Update"
Then I should be redirected to the users page
	And I should see "Successfully updated courses"
	And 1 courses_students should exist with course: course "ruby", student: user "reiko"
	And 1 courses_students should exist with course: course "fortran", student: user "reiko"
	And 2 courses_students should exist
	And 0 teachings should exist
	
Scenario: Select teacher courses
Given a user is logged in as "aya"
When I browse to the teachers page
	And I follow "Courses" within user "johan"
	And I check "Ruby III"
	And I check "Fortran I"
	And I press "Update"
Then I should be redirected to the users page
	And I should see "Successfully updated courses"
	And a courses_teacher should exist with course: course "ruby", teacher: user "johan"
	And a courses_teacher should exist with course: course "fortran", teacher: user "johan"
	And 2 courses_teachers should exist
	And 0 courses_students should exist

@update
Scenario: Update student courses
Given a user: "reiko" exist with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"
	And a user is logged in as "aya"
	And a courses_student join model exists with course: "Ruby III", student: "reiko"
	And a courses_student join model exists with course: "Fortran I", student: "reiko"
When I browse to the students page
	And I follow "Courses" within user "reiko"
Then the "Ruby III" checkbox should be checked
  And the "Rails II" checkbox should not be checked
  And the "Fortran I" checkbox should be checked
When I uncheck "Fortran I"
	And I check "Rails II"
	And I press "Update"
Then I should be redirected to the users page
	And I should see "Successfully updated courses"
	And 1 courses_students should exist with course: course "ruby", student: user "reiko"
	And 1 courses_students should exist with course: course "rails", student: user "reiko"
	And 2 courses_students should exist
	And 0 teachings should exist
	
Scenario: Update teacher courses
Given a user is logged in as "aya"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a courses_teacher exists with course: course "fortran", teacher: user "johan"
When I browse to the teachers page
	And I follow "Courses" within user "johan"
Then the "Ruby III" checkbox should be checked
  And the "Rails II" checkbox should not be checked
  And the "Fortran I" checkbox should be checked
When I uncheck "Fortran I"
	And I check "Rails II"
	And I press "Update"
Then I should be redirected to the users page
	And I should see "Successfully updated courses"
	And a courses_teacher should exist with course: course "ruby", teacher: user "johan"
	And a courses_teacher should exist with course: course "rails", teacher: user "johan"
	And 2 courses_teachers should exist
	And 0 courses_students should exist
	
@allow-rescue
Scenario Outline: Only admins can set courses
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user is logged in as "<user>"
When I go to the edit courses page for user: "johan"
Then I should be redirected to the events page
Examples:
|	user		|
|	thomas	|
|	prince	|
|	junko		|
|	mika		|