Scenario: View
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user is logged in as "johan"
When I browse to the teachers page
	And I follow "Weekly Mail" within user "thomas"
Then I should be redirected to the mailer page