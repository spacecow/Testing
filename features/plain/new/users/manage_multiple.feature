Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	
Scenario: Edit multiple
Given a course: "rails" exists with name: "Rails II"
	And a course: "fortran" exists with name: "Fortran I"
	And a course: "ruby" exists with name: "Ruby III"
Given a user is logged in as "aya"
When I go to the users page
	And I check user "thomas"
	And I check user "prince"
	And I check user "junko"
	And I press "Courses"
Then I should see "Thomas Osburg, Prince Philip, Junko Sumii"
	And the "Rails II" checkbox should not be checked
	And the "Fortran I" checkbox should not be checked
	And the "Ruby III" checkbox should not be checked
When I check "Rails II"
	And I check "Ruby III"
	And I press "Update"
Then I should be redirected to the users page
	And 1 courses_students should exist with course: course "ruby", student: user "thomas"
	And 1 courses_students should exist with course: course "ruby", student: user "prince"
	And 1 courses_students should exist with course: course "ruby", student: user "junko"
	And 1 courses_students should exist with course: course "rails", student: user "thomas"
	And 1 courses_students should exist with course: course "rails", student: user "prince"
	And 1 courses_students should exist with course: course "rails", student: user "junko"
	And 6 courses_students should exist
