@user_registration
Background:
Given a setting exists with name: "main"

Scenario: A guest can make a simple registration in japanese
Given an invitation exists with recipient_email: "akira@docomo.ne.jp"
When I signup with that invitation
Then I should not see 'role'
	And the "メールアドレス*" field should contain "akira@docomo.ne.jp"
	And the 'nationality' field should contain "日本"
	And "日本語" should be selected in "user_language"
When I fill in 'user_name' with "kurosawa_akira"
	And I fill in 'name' with "黒澤 明"
	And I fill in 'name_hurigana' with "くろさわ あきら"
	And I fill in 'password' with "secret"
	And I fill in 'password_confirmation' with "secret"
	And I press 'create'
Then I should be redirected to the error users page
When I choose 'female'
	And I select "英語" from 'language'
	And I press 'create'
Then I should be redirected to the events page
	And a user should exist with role: "registrant", language: "en"
	And I should see "Events"

Scenario: A guest can make a simple registration in english
Given an invitation exists with recipient_email: "prince@docomo.ne.jp"
When I signup with that invitation
	And I follow "English"
Then I should not see 'role'
	And the "Email Address*" field should contain "prince@docomo.ne.jp"
	And I should see "Occupation"
	And I should not see "Occupation*"
	And "English" should be selected in "user_language"
	And the 'nationality' field should contain ""
When I fill in 'user_name' with "prince_philip"
Then the 'user_name' field should contain "prince_philip"
When I fill in 'name' with "Prince Philip"
	And I fill in 'nationality' with "Swedish"
	And I choose "female"
	And I fill in 'password' with "secret"
	And I fill in 'password_confirmation' with "secret"
	And I press 'create'
Then I should be redirected to the error users page
When I fill in 'name_hurigana' with "プリンス　ヒリプ"
	And I press 'create'
Then I should be redirected to the events page
	And a user should exist with role: "registrant", language: "en"
	And I should see 'users.notice.new_registration'
	And I should see "Events"

#@avatar
#Scenario: Avatar error messages
#Given I go to the events page
#	And I follow "English"
#When I follow 'register'
#	And I press "Create"
#Then I should not see "Avatar content type is not a picture"
#When I attach the file at "C:/aaw7boot.log" to "Avatar"
#	And I press "Create"
#Then I should see "Avatar content type is not a picture"
#When I attach the file at "C:/Pictures/sadako_face.jpg" to "Avatar"
#And I press "Create"
#Then I should not see "Avatar content type is not a picture"


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