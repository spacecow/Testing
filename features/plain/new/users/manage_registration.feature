@user_registration
Scenario: A guest can make a simple registration in english
Given I go to the events page
	And I follow "English"
When I follow 'register'
Then I should not see 'role'
	And "English" should be selected in "user_language"
	And the 'nationality' field should contain ""
When I fill in 'user_name' with "prince_philip"
	And I fill in 'name' with "Prince Philip"
	And I fill in 'nationality' with "Swedish"
	And I choose "female"
	And I fill in 'password' with "secret"
	And I fill in 'password_confirmation' with "secret"
	And I press 'create'
Then I should be redirected to the error users page
When I fill in 'email' with "prince@docomo.ne.jp"
	And I fill in 'name_hurigana' with "プリンス　ヒリプ"
	And I press 'create'
Then I should be redirected to the events page
	And a user should exist with role: "registrant", language: "en"
	And I should see 'users.notice.registration'
	And I should see "Events"
	
Scenario: A guest can make a simple registration in japanese
Given I go to the events page
When I follow 'register'
Then I should not see 'role'
	And the 'nationality' field should contain "日本"
	And "日本語" should be selected in "user_language"
When I fill in 'user_name' with "kurosawa_akira"
	And I fill in 'name' with "黒澤 明"
	And I fill in 'name_hurigana' with "くろさわ あきら"
	And I choose 'female'
	And I fill in 'password' with "secret"
	And I fill in 'password_confirmation' with "secret"
	And I press 'create'
Then I should be redirected to the error users page
When I fill in 'email' with "akira@docomo.ne.jp"
	And I select "英語" from 'language'
	And I press 'create'
Then I should be redirected to the events page
	And a user should exist with role: "registrant", language: "en"
	And I should see "Events"

Scenario: Edit function
Given a user: "kurosawa" exists with username: "kurosawa_akira", language: "ja", male: false, age: "10"
	And a user is logged in as "kurosawa_akira"
When I go to the events page
	And I follow 'edit_profile'
Then "日本語" should be selected in "user_language"
	And the 'female' checkbox should be checked
	And the 'male' checkbox should not be checked
	And "10代" should be selected in "user_age"
	
# 正常にﾛｸﾞｱｳﾄされました