@delete
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exists with username: "aya", role: "admin, teacher", language: "en", name: "Junko Sumii"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "prince" exists with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"
	And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
	And a user: "kurosawa" exists with username: "kurosawa", role: "registrant, student", language: "ja", name: "Akira Kurosawa"	
	And a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"	
	And a course: "ruby" exists with name: "Ruby I"
	And a classroom: "room1" exists with name: "1"
	And a template class exists with course: course "ruby", classroom: classroom "room1", teacher: user "prince"
	
Scenario Outline: Delete a template class and no associations should be deleted (later on students?)
Given a user is logged in as "<user>"
Then 1 template_classes should exist
	And 1 courses should exist
	And 1 classrooms should exist
	And 7 users should exist
	And 4 teachers should exist
When I go to the show page of the template class
	And I follow "Del" within "div#links"
Then I should be redirected to the template classes page
	And I should see "Successfully deleted template class" within "div#notice"
	And 0 template_classes should exist
	And 1 courses should exist
	And 1 classrooms should exist
	And 7 users should exist
	And 4 teachers should exist	
Examples:
|	user	|
|	johan	|
|	aya		|
	
#Given I should have 2 template classes
#When I follow 'delete' within "template_klass_1"
#Then I should be redirected to the list of template classes
#	And I should have 1 template class
#When I follow 'delete' within "template_klass_2"
#Then I should be redirected to the list of template classes
#	And I should have 0 template classes	