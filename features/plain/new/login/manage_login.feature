Scenario: Log in
Given a setting exists with name: "main"
	And a user exists with username: "kurosawa_akira", language: "ja"
	And I go to the events page
When I follow 'login.text'
	And I fill in 'user_name' with "kurosawa_akira"
	And I fill in 'password' with "secret"
	And I press 'login.button'
Then I should be redirected to the events page
	And I should see 'login.notice.success'