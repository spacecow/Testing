Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"
	
@all
Scenario: View of users
Given a user is logged in as "johan"
When I go to the users page
Then "All" should be selected in the "Sort" menu
	And I should see "Johan Sveholm, Aya Komatsu, Thomas Osburg, Prince Philip, Junko Sumii, Mika Mikachan, Reiko Arikawa" within the users table
	And I should see links "Info, Edit, Role, Del" within user "johan"
	And I should see a button "Roles"
	And I should not see a button "Courses"
	
Scenario: View of teachers
Given a user is logged in as "johan"
When I go to the users page
	And I select "Teachers" from "Sort"
	And I press "Go!"
Then "Teachers" should be selected in the "Sort" menu
	And I should see "Johan Sveholm, Aya Komatsu, Thomas Osburg, Prince Philip" within the users table
	And I should not see "Junko Sumii, Mika Mikachan, Reiko Arikawa"
	And I should see links "Info, Edit, Role, Courses, Del" within user "johan"
	And I should see a button "Roles"
	And I should see a button "Teacher Courses"
	
Scenario: View of students
Given a user is logged in as "johan"
When I go to the users page
	And I select "Students" from "Sort"
	And I press "Go!"
Then "Students" should be selected in the "Sort" menu
	And I should see "Junko Sumii, Reiko Arikawa" within the users table
	And I should not see "Johan Sveholm, Aya Komatsu, Thomas Osburg, Prince Philip, Mika Mikachan"
	And I should see links "Info, Edit, Role, Courses, Del" within user "junko"
	And I should see a button "Roles"
	And I should see a button "Student Courses"