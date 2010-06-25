Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exist with username: "junko", role: "student, registrant", language: "en", name: "Junko Sumii"
	And a course: "ruby" exists with name: "Ruby I"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a klass: "ruby" exists with course: course "ruby", start_time: "18:50", end_time: "20:50", date: "2011-02-28"

Scenario: For the time being, students can see confirmed teachers
Given a teaching exists with klass: klass "ruby", teacher: user "johan", current: true, status_mask: 33
	And a user is logged in as "junko"
When I browse to the klasses page of "February 28, 2011"
Then I should see "Johan Sveholm" as teacher within klass: "ruby"

Scenario Outline: If the teacher is not confirmed, he should not be seen by students
Given a teaching exists with klass: klass "ruby", teacher: user "johan", current: true, status_mask: <status>
	And a user is logged in as "junko"
When I browse to the klasses page of "February 28, 2011"
Then I should see no teacher within klass: "ruby"
Examples:
|	status	|
|	2				|
|	4				|