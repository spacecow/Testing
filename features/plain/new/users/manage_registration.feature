@user_registration
Background:
Given a setting exists with name: "main"

Scenario: An invited guest can make a simple registration in japanese
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
	And I press 'register'
Then I should be redirected to the error users page
When I choose 'female'
	And I select "英語" from 'language'
	And I press 'register'
Then I should be redirected to the events page
	And a user should exist with role: "registrant", language: "en"
	And I should see "Events"

@avatar
Scenario: An invited guest can make a simple registration in english
Given an invitation exists with recipient_email: "prince@docomo.ne.jp"
When I signup with that invitation
	And I follow "English"
Then I should not see 'role'
	And the "Email Address*" field should contain "prince@docomo.ne.jp"
	And "user_occupation" should have a blank option
	And "user_age" should have a blank option
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
	And I press 'register'
Then I should be redirected to the error users page
When I fill in 'name_hurigana' with "プリンス　ヒリプ"
	And "" should be selected in "user_occupation"
	And "" should be selected in "user_age"
	And I press 'register'
Then I should be redirected to the events page
	And a user should exist with role: "registrant", language: "en"
	And I should see 'users.notice.new_registration'
	And I should see "Events"

Scenario: A user can not unset certain attributes that were set in an event registration
Given a user exists with username: "kurosawa", role: "registrant", language: "en"
	And a user is logged in as "kurosawa"
	And an event: "christmas" exists with title_en: "Christmas Party"
	And I am registered for that event
When I follow "Edit Profile"
Then "Exchange Student" should be selected in "user_occupation"
	And "user_occupation" should have no blank option
Then "10's" should be selected in "user_age"
	And "user_age" should have no blank option

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

Scenario: Klargoer vad som aer foer och efternamn (NOT IMPLEMENTED)
Given not implemented
	
Scenario: Nationality drop-down (NOT IMPLEMENTED)
Given not implemented

Scenario: Avatar strular vid registreringoegonblicket (NOT IMPLEMENTED)
Given not implemented

Scenario: Check if it is ok to have japanese in the username (NOT IMPLEMENTED)
Given not implemented

Scenario: Absolute value for occupation so that english&japanese doesnt mix (NOT IMPLEMENTED)
Given not implemented

Scenario: Will comments dissapear if user is deleted? (NOT IMPLEMENTED)
Given not implemented