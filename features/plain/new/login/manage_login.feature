Background:
Given a setting exists with name: "main"
	And a user exists with username: "kurosawa_akira", language: "ja", role: "registrant, student"
	
Scenario: Log in
When I go to the events page
	And I follow 'login.text'
Then I should not see "ログイン" within "legend"
When I fill in 'user_name' with "kurosawa_akira"
	And I fill in 'password' with "secret"
	And I press 'login.button'
Then I should be redirected to the events page
	And I should not see 'login.notice.success'

@allow-rescue
Scenario: Log in with redirect
When I go to the klasses page
Then I should be redirected to path "/login_user"
When I fill in 'user_name' with "kurosawa_akira"
	And I fill in 'password' with "secret"
	And I press 'login.button'
Then I should be redirected to the klasses page

Scenario: Log out
Given a user is logged in as "kurosawa_akira"
When I follow 'logout.text'
Then I should not see "ページを許可されません"
And I should see "正常にログアウトされました"
	
Scenario: Display error login message
When I go to path "/login_user"
	And I follow "English"
	And I fill in "User name" with "fe"
	And I press "Login"
Then I should see "cannot be blank"
When I fill in "Password" with "fe"
	And I press "Login"
Then I should see "is not valid"
When I fill in "User name" with "kurosawa_akira"
	And I press "Login"
Then I should see "cannot be blank"
When I fill in "Password" with "fe"
	And I press "Login"
Then I should see "is not valid"

Scenario: If you are logged in you should not be able to see the login page
Given a user is logged in as "kurosawa_akira"
When I go to path "/login_user"
Then I should be redirected to the events page

Scenario: The username is filled in if it is given in the url
When I go to path "/login_user"
	And I follow "English"
Then the "User name" field should be blank
Then the "Password" field should be blank
When I go to path "/login_user/jinjin"
Then the "User name" field should contain "jinjin"
Then the "Password" field should be blank

@pending
Scenario: If a user inputs a wrong url, he should be taken to the root page (NOT IMPLEMENTED)

@pending
Scenario: No error messages! (NOT IMPLEMENTED)

