Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "teacher, admin", language: "en", name: "Aya Komatsu"
	And a course: "ruby" exists with name: "Ruby II"
	And a klass: "ruby" exists with course: course "ruby", date: "2011-02-28"


@deleting
Scenario: When deleting a class that has teachings, the teachings should also be deleted
Given a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a courses_teacher exists with course: course "ruby", teacher: user "aya"
	And a teaching exists with klass: klass "ruby", teacher: user "aya", current: false
	And a teaching exists with klass: klass "ruby", teacher: user "johan", current: true
	And a user is logged in as "aya"
Then 2 teachings should exist
When I browse to the klasses page of "February 28, 2011"
	And I follow "Del" within "table#Ruby tr td#links"
Then I should automatically browse to the klasses page of "February 28, 2011"
	And I should see "Successfully deleted class." as notice flash message
	And 0 klasses should exist
	And 0 teachings should exist

Scenario: A class with students cannot be deleted
Given a user: "junko" exist with username: "junko", role: "student, registrant", language: "en", name: "Junko Sumii"
	And an attendance exists with klass: klass "ruby", student: user "junko"
	And a user is logged in as "aya"
Then 1 attendances should exist
When I browse to the klasses page of "February 28, 2011"
	And I follow "Del" within "table#Ruby tr td#links"
Then I should automatically browse to the klasses page of "February 28, 2011"
	And I should see "Move away all students (1) from the class before deleting." as error flash message
	And 1 klasses should exist
	And 1 attendances should exist
	
@pending
Scenario: Show error message when trying to delete a class with students

@pending
Scenario: Should be able to delete teaching (NOT IMPLEMENTED)

@pending
Scenario: Warning if teacher information goes lost when trying to delete a class?