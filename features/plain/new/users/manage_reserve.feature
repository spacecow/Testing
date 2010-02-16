Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"

Scenario: View of the reserve page
Given a user is logged in as "johan"
When I go to the reserve page for user: "johan"
Then I should see "Reserve" as title	

Scenario: Same class should not be displayed double
Given a course: "ruby" exists with name: "Ruby I"
	And a klass exists with date: "2010-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2010-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a user is logged in as "johan"
When I go to the reserve page for user: "johan"
Then I should not see "2/16(Tuesday) - Ruby I - 12:00~13:00 2/16(Tuesday) - Ruby I - 12:00~13:00"

Scenario: Classes should be displayed in order after day, time interval
Given a course: "ruby" exists with name: "Ruby I"
	And a klass exists with date: "2010-02-17", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2010-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2010-02-16", course: course "ruby", start_time: "11:00", end_time: "12:00"
	And a klass exists with date: "2010-02-19", course: course "ruby", start_time: "17:00", end_time: "18:00"
	And a klass exists with date: "2010-02-19", course: course "ruby", start_time: "09:00", end_time: "13:00"
	And a klass exists with date: "2010-02-17", course: course "ruby", start_time: "09:00", end_time: "13:00"
	And a user is logged in as "johan"
When I go to the reserve page for user: "johan"
Then I should see "2/16(Tuesday) - Ruby I - 11:00~12:00 2/16(Tuesday) - Ruby I - 12:00~13:00 2/17(Wednesday) - Ruby I - 09:00~13:00 2/17(Wednesday) - Ruby I - 12:00~13:00 2/19(Friday) - Ruby I - 09:00~13:00 2/19(Friday) - Ruby I - 17:00~18:00"

Scenario: Reserve a class
Given a course: "ruby" exists with name: "Ruby I"
	And a klass exists with date: "2010-02-17", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2010-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a user is logged in as "johan"
When I go to the reserve page for user: "johan"
	And I check "2/16(Tuesday) - Ruby I - 12:00~13:00"
	And I press "Reserve"
Then 1 attendances should exists

Scenario: Class history (NOT IMPLEMENTED)
Given not implemented

Scenario: Regular student should not be able to uncheck a reservation (NOT IMPLEMENTED)
Given not implemented