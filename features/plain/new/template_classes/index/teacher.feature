Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a course: "ruby" exists
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a user is logged in as "johan"
	
@set_teacher
Scenario: Set teacher for a class
Given a template class: "ruby" exists with course: course "ruby", day: "mon"
When I browse to the template classes page of "Monday"
	And I set "Johan Sveholm" as teacher within template class "ruby"
Then 1 template_classes should exist with teacher: user "johan"

@unset_teacher
Scenario: Unset teacher for a class
Given a template class: "ruby" exists with course: course "ruby", teacher: user "johan", day: "mon"
When I browse to the template classes page of "Monday"
	And I set "" as teacher within template class "ruby"
Then 1 template_classes should exist with teacher_id: nil