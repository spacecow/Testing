Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exist with username: "junko", role: "student, registrant", language: "en", name: "Junko Sumii"
	And a klass exists
	
Scenario: View of attendances
Given an attendance "junko" exists with klass: the klass, student: user "junko"
	And a user is logged in as "johan"
When I go to the show page of the klass
Then I should see "Students" as title within the attendances section
	And I should not see "No students" within the attendances section
	And I should see "table#attendances" table
	|	Junko Sumii	|	Late Cancel Absent Delete |

Scenario: A regular user can not see the students listed
Given an attendance "junko" exists with klass: the klass, student: user "junko"
	And a user is logged in as "junko"
When I go to the show page of the klass
Then the page should have no "attendances" id section

Scenario: If there are no attendances, a message should say so
Given a user is logged in as "johan"
When I go to the show page of the klass
Then I should see "No students" within the attendances section