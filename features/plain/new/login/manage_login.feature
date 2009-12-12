Background:
Given a setting exists with name: "main"
	And a user exists with username: "kurosawa_akira", language: "ja"
	
Scenario: Log in
When I go to the events page
	And I follow 'login.text'
	And I fill in 'user_name' with "kurosawa_akira"
	And I fill in 'password' with "secret"
	And I press 'login.button'
Then I should be redirected to the events page
	And I should see 'login.notice.success'
	
Scenario: Log out
Given a user is logged in as "kurosawa_akira"
When I follow 'logout.text'
Then I should not see "ページを許可されません"
	And I should see "正常にログアウトされました"
	
Scenario: Display error login message (NOT IMPLEMENTED)
Given not implemented

Scenario: Display a better path than "user_sessions" (NOT IMPLEMENTED)
Given not implemented