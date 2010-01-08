@password
Background:
Given a setting exists with name: "main"

Scenario: A user cannot change his password without the correct pass-key
When I go to path "/change_password/fefe"
Then I should be redirected to the root page
	And I should see "パスワードをリセットするために正しいパスキーを手に入れて" within "#error"

Scenario: A pass-key can only be used once
Given a user exists with username: "kurosawa", name: "Kurosawa Akira", language: "en"
	And a reset password exists with username: "kurosawa", user: that user, used: true
When I change password with that reset password
Then I should be redirected to the root page
	And I should see "このパスキーがもう使われてしまいました" within "#error"

@correct_password
Scenario: Change password with a correct pass-key
Given a user exists with username: "kurosawa", name: "Kurosawa Akira", language: "en"
	And a reset password exists with username: "kurosawa", user: that user
	And I change password with that reset password
When I follow "English"
Then I should see "Change password" within "legend"
	And I should see "Change password for user: Kurosawa Akira" within "div.intro"
When I press "Change"
Then I should see "New password*can't be blank"
When I fill in "New password" with "majkvast"
	And I fill in "New password confirmation" with "majkvast"
	And I press "Change"
Then I should be redirected to the events page
	And I should see "Successfully changed password."
	And 1 reset_passwords should exist with used: true
When I follow "Logout"
	And I fill in "User name" with "kurosawa"
	And I fill in "Password" with "secret"
	And I press "Login"
Then I should see "Passwordis not valid"
When I fill in "User name" with "kurosawa"
	And I fill in "Password" with "majkvast"
	And I press "Login"
Then I should be redirected to the events page
	
Scenario: Be able to change password when you are logged in (NOT IMPLEMENTED)
Given not implemented