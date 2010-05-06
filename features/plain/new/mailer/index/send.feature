Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg", email: "thomas@space.com"
	And a course exists with name: "Ruby I"
	And a klass: "1" exists with date: "2011-12-24", course: that course, start_time: "12:00", end_time: "13:00"
	And a teaching exists with klass: that klass, teacher: user "thomas", status_mask: 33
	And a user is logged in as "johan"
	
Scenario: After sending the mail, the same page with the same options should be reloaded
When I browse to the "Weekly Mail" page for user "thomas" of "December 24, 2011"
	And I press "Send"
Then "December 24, 2011" should be selected as date in the select menu
	And "Thomas Osburg" should be selected as teacher in the select menu
	And "English" should be selected as language in the select menu
	And "Weekly Teacher Schedule" should be selected as type in the select menu

@send
Scenario: Send a mail
When I browse to the "Daily Mail" page for user "thomas" of "December 24, 2011"
	And I press "Send"
Then "thomas@space.com" should receive 1 email
When "thomas@space.com" opens the email with subject "Reminder"
Then I should see the daily teacher reminder mail in english in the email body
