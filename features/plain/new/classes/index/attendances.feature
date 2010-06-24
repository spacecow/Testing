Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "junko" exist with username: "junko", role: "student, registrant", language: "en", name: "Junko Sumii"
	And a course: "ruby" exists with name: "Ruby I"
	And a klass: "ruby1" exists with course: course "ruby", date: "2010-02-28", start_time: "11:00", end_time: "12:00"
	And a klass: "ruby2" exists with course: course "ruby", date: "2010-02-28", start_time: "11:00", end_time: "12:00"
	And an attendance exists with klass: klass "ruby1", student: user "junko"
	And a user is logged in as "johan"
	
Scenario: View of attendances
When I browse to the klasses page of "February 28, 2010"
Then I should see student "junko" within klass "ruby1"
And I should see no students within klass "ruby2"

Scenario: Cancel a student
When I browse to the klasses page of "February 28, 2010"
When I cancel student "junko" in klass "ruby1"
And I should see no students within klass "ruby1"

Scenario: Move a student from one klass to another
When I browse to the klasses page of "February 28, 2010"
When I move student "junko" from klass "ruby1" to klass 2
Then I should see student "junko" within klass "ruby2"	

Scenario: Moving multple students within a klass
Given a user: "reiko" exist with username: "reiko", role: "student, registrant", language: "en", name: "Reiko Arikawa"
	And an attendance exists with klass: klass "ruby2", student: user "reiko"
When I browse to the klasses page of "February 28, 2010"
	And I prepare to move student "junko" from klass "ruby1" to klass 2
	And I prepare to move student "reiko" from klass "ruby2" to klass 1
	And I press "Update"
Then I should see student "reiko" within klass "ruby1"
Then I should see student "junko" within klass "ruby2"

Scenario: Moving multple students within multiple klasses
Given a user: "reiko" exist with username: "reiko", role: "student, registrant", language: "en", name: "Reiko Arikawa"
	And a klass: "ruby3" exists with course: course "ruby", date: "2010-02-28", start_time: "13:00", end_time: "14:00"
	And a klass: "ruby4" exists with course: course "ruby", date: "2010-02-28", start_time: "13:00", end_time: "14:00"
	And an attendance exists with klass: klass "ruby2", student: user "reiko"
	And an attendance exists with klass: klass "ruby3", student: user "reiko"
	And an attendance exists with klass: klass "ruby4", student: user "junko"
When I browse to the klasses page of "February 28, 2010"
	And I prepare to move student "junko" from klass "ruby1" to klass 2
	And I prepare to move student "reiko" from klass "ruby2" to klass 1
	And I prepare to move student "reiko" from klass "ruby3" to klass 2
	And I prepare to move student "junko" from klass "ruby4" to klass 1	
	And I press "Update"
Then I should see student "reiko" within klass "ruby1"
	And I should see student "junko" within klass "ruby2"
	And I should see student "junko" within klass "ruby3"
	And I should see student "reiko" within klass "ruby4"
