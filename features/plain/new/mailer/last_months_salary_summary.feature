Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", email: "johan@space.com"

@last_months_format
Scenario: Check the mail of last month's salary format
Given a klass exists last month the 23rd
	And a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 33
When the system sends out the last month's salary summary to concerned teachers
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "#last_month's Salary"
Then I should see the last month's salary summary mail in english in the email body
