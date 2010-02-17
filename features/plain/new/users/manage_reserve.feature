Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"

Scenario: View of the reserve page
Given a user is logged in as "johan"
When I go to the reserve page for user: "johan"
Then I should see "Reserve" as title	

Scenario: Same class should not be displayed double
Given a course: "ruby" exists with name: "Ruby I"
	And a klass exists with date: "2012-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2012-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a user is logged in as "johan"
When I go to the reserve page for user: "johan"
Then I should see "2/16(Thursday) - Ruby I - 12:00~13:00"
	And I should not see "2/16(Thursday) - Ruby I - 12:00~13:00 2/16(Thursday) - Ruby I - 12:00~13:00"

Scenario: Classes should be displayed in order after day, time interval
Given a course: "ruby" exists with name: "Ruby I"
	And a klass exists with date: "2012-02-17", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2012-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass exists with date: "2012-02-16", course: course "ruby", start_time: "11:00", end_time: "12:00"
	And a klass exists with date: "2012-02-19", course: course "ruby", start_time: "09:00", end_time: "13:00"
	And a klass exists with date: "2012-02-19", course: course "ruby", start_time: "17:00", end_time: "18:00"
	And a klass exists with date: "2012-02-17", course: course "ruby", start_time: "09:00", end_time: "13:00"
	And a user is logged in as "johan"
When I go to the reserve page for user: "johan"
Then I should see "2/16(Thursday) - Ruby I - 11:00~12:00 2/16(Thursday) - Ruby I - 12:00~13:00 2/17(Friday) - Ruby I - 09:00~13:00 2/17(Friday) - Ruby I - 12:00~13:00 2/19(Sunday) - Ruby I - 09:00~13:00 2/19(Sunday) - Ruby I - 17:00~18:00"

@reserve
Scenario: Reserve a class
Given a course: "ruby" exists with name: "Ruby I"
	And a klass exists with date: "2012-02-17", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass16" exists with date: "2012-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a user is logged in as "johan"
When I go to the reserve page for user: "johan"
Then I should see "Classes you can reserve" within "div.reservable"
	And I should see "2/16(Thursday) - Ruby I - 12:00~13:00" within "div.reservable"
	And I should see "2/17(Friday) - Ruby I - 12:00~13:00" within "div.reservable"
	And the page should have no "reserved" section
	And I check "2/16(Thursday) - Ruby I - 12:00~13:00"
	And I press "Reserve"
Then 1 attendances should exist with student: user "johan", klass: klass "klass16"

@another_class
Scenario: Reserve another class
Given a course: "ruby" exists with name: "Ruby I"
	And a klass: "klass17" exists with date: "2012-02-17", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass16" exists with date: "2012-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And an attendance exists with student: user "johan", klass: klass "klass16"
	And a user is logged in as "johan"
When I go to the reserve page for user: "johan"
Then I should see "Classes you can reserve" within "div.reservable"
	And I should not see "2/16(Thursday) - Ruby I - 12:00~13:00" within "div.reservable"
	And I should see "2/17(Friday) - Ruby I - 12:00~13:00" within "div.reservable"
	And I should see "Reserved classes" within "div.reserved"
	And I should see "2/16(Thursday) - Ruby I - 12:00~13:00" within "div.reserved"
	And I should not see "2/17(Friday) - Ruby I - 12:00~13:00" within "div.reserved"
When I check "2/17(Friday) - Ruby I - 12:00~13:00"
	And I press "Reserve"
Then 1 attendances should exist with student: user "johan", klass: klass "klass16"
Then 1 attendances should exist with student: user "johan", klass: klass "klass17"

Scenario: If there are no classes to reserve, that section should not be visable
Given a course: "ruby" exists with name: "Ruby I"
	And a klass: "klass17" exists with date: "2012-02-17", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass16" exists with date: "2012-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And an attendance exists with student: user "johan", klass: klass "klass16"
	And an attendance exists with student: user "johan", klass: klass "klass17"
	And a user is logged in as "johan"
When I go to the reserve page for user: "johan"
	Then the page should have no "reservable" section
	And I should see "Reserved classes" within "div.reserved"
	And I should see "2/16(Thursday) - Ruby I - 12:00~13:00" within "div.reserved"
	And I should see "2/17(Friday) - Ruby I - 12:00~13:00" within "div.reserved"	

@already_reserved
Scenario Outline: If a class exists doubled, the one in use should be displayed
Given a course: "ruby" exists with name: "Ruby I"
	And a klass: "klass16-1" exists with date: "2012-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass16-2" exists with date: "2012-02-16", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And an attendance exists with student: user "johan", klass: klass "<klass>"
	And a user is logged in as "johan"
When I go to the reserve page for user: "johan"
Then I should see "2/16(Thursday) - Ruby I - 12:00~13:00" within "div.reserved"
	And the page should have no "reservable" section
Examples:
|	klass			|
|	klass16-1	|
|	klass16-2	|

Scenario: Class history (NOT IMPLEMENTED)
Given not implemented
