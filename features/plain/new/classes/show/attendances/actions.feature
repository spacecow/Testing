Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exist with username: "junko", role: "student, registrant", language: "en", name: "Junko Sumii"
	And a klass exists
	And an attendance "junko" exists with klass: the klass, student: user "junko"
	And a user is logged in as "johan"

@cancel			
Scenario: Cancel a student
When I go to the show page of the klass
	And I follow "Cancel" within the attendances section
Then I should see "table#attendances" table
|	Junko Sumii	|	Late Un-cancel Absent Delete|
	And an attendance "junko" should exist with klass: the klass, student: user "junko", cancel: true, late: false, absent: false

Scenario: Un-cancel a student
Given attendance "junko" has extra: cancel: true
When I go to the show page of the klass
	And I follow "Un-cancel" within the attendances section
Then I should see "table#attendances" table
|	Junko Sumii	|	Late Cancel Absent Delete|
	And an attendance "junko" should exist with klass: the klass, student: user "junko", cancel: false, late: false, absent: false

@late
Scenario: Mark a student as Late
When I go to the show page of the klass
	And I follow "Late" within the attendances section
Then I should see "table#attendances" table
|	Junko Sumii	|	In Time Cancel Absent Delete|
	And an attendance "junko" should exist with klass: the klass, student: user "junko", cancel: false, late: true, absent: false
	
@in_time
Scenario: Mark a student as In Time
Given attendance "junko" has extra: late: true
When I go to the show page of the klass
	And I follow "In Time" within the attendances section
Then I should see "table#attendances" table
|	Junko Sumii	|	Late Cancel Absent Delete|
	And an attendance "junko" should exist with klass: the klass, student: user "junko", cancel: false, late: false, absent: false

Scenario: Mark a student as Absent
When I go to the show page of the klass
	And I follow "Absent" within the attendances section
Then I should see "table#attendances" table
|	Junko Sumii	|	Late Cancel Present Delete|
	And an attendance "junko" should exist with klass: the klass, student: user "junko", cancel: false, late: false, absent: true

Scenario: Mark a student as Absent
Given attendance "junko" has extra: absent: true
When I go to the show page of the klass
	And I follow "Present" within the attendances section
Then I should see "table#attendances" table
|	Junko Sumii	|	Late Cancel Absent Delete|
	And an attendance "junko" should exist with klass: the klass, student: user "junko", cancel: false, late: false, absent: false

Scenario: Delete a student
When I go to the show page of the klass
	And I follow "Del" within the attendances section
Then I should see "No students" within the attendances section
	And 0 attendances should exist

	
@pending
Scenario: Japanese translations for In Time and Late