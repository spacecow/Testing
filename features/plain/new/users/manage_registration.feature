@user_registration
Scenario: A guest can make a simple registration in english
Given I go to the events page
	And I follow "English"
When I follow 'register'
Then I should not see 'role'
	And "english" should be selected in "user_language"
When I fill in 'user_name' with "prince_philip"
	And I fill in 'name' with "Prince Philip"
	And I fill in 'nationality' with "Swedish"
	And I choose "female"
	And I fill in 'password' with "secret"
	And I fill in 'password_confirmation' with "secret"
	And I press 'create'
Then I should be redirected to the error users page
When I fill in 'email' with "prince@docomo.ne.jp"
	And I press 'create'
Then I should be redirected to the events page
	And I should see 'users.notice.registration'
	
Scenario: A guest can make a simple registration in japanese
Given I go to the events page
When I follow 'register'
Then I should not see 'role'
	And "japanese" should be selected in "user_language"
When I fill in 'user_name' with "kurosawa_akira"
	And I fill in 'name' with "黒澤 明"
	And I fill in 'name_hurigana' with "くろさわ あきら"
	And I choose 'female'
	And I fill in 'password' with "secret"
	And I fill in 'password_confirmation' with "secret"
	And I press 'create'
Then I should be redirected to the error users page
When I fill in 'email' with "akira@docomo.ne.jp"
	And I press 'create'
Then I should be redirected to the events page
	And I should see 'users.notice.registration'
	
Scenario: Age/gender should be stored as a value, japanese&english differ (NOT IMPLEMENTED)
Given not implemented	


# 正常にﾛｸﾞｱｳﾄされました