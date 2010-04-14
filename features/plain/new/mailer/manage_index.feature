Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user is logged in as "johan"
When I browse to the teachers page

Scenario Outline: If no teachings exists there should be no error
When I follow "<link> Mail" within user "thomas"
Then I should be redirected to the mailer page
Examples:
|	link		|
|	Weekly	|
|	Daily		|

Scenario: Display daily mail view
Given a course exists with name: "Ruby I"
	And a klass exists with date: "2011-12-24", course: that course, start_time: "12:00", end_time: "12:50"
	And a teaching exists with klass: that klass, teacher: user "thomas"
When I follow "Daily Mail" within user "thomas"
	And I select "December 24, 2011" as date
	And I press "Go!"
#Then I should see "Ruby" within "div#list"

Scenario: Only admins can send out reminders manually (NOT IMPLEMENTED)
Given not implemented