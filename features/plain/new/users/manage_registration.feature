@user_registration
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "god, teacher", name: "Johan Sveholm"

Scenario: An invited guest can make a simple registration in japanese
Given an invitation exists with recipient_email: "akira@docomo.ne.jp"
When I signup with that invitation
Then I should not see 'role'
	And the "メールアドレス*" field should contain "akira@docomo.ne.jp"
	And the 'nationality' field should contain "日本"
	And "日本語" should be selected in "user_language"
	And the "システム内メールを外部メールボックスに転送したい" checkbox should be checked
When I fill in 'user_name' with "kurosawa_akira"
	And I fill in 'name' with "黒澤 明"
	And I fill in 'name_hurigana' with "くろさわ あきら"
	And I fill in 'password' with "secret"
	And I fill in 'password_confirmation' with "secret"
	And I uncheck "システム内メールを外部メールボックスに転送したい"
	And I press 'register'
Then I should be redirected to the error users page
	And the "システム内メールを外部メールボックスに転送したい" checkbox should not be checked
When I choose 'female'
	And I select "英語" from "このサイトはどんな言語で利用する？*"
	And I press 'register'
Then I should be redirected to the events page
	And a user should exist with roles_mask: 48, language: "en", info_update: false
	And I should see "Events"

Scenario Outline: Some usernames/names are not allowed
Given an invitation exists with recipient_email: "prince@docomo.ne.jp"
When I signup with that invitation
	And I follow "English"
	And I fill in "Name" with "<word1>"
	And I fill in "User name" with "<word1>"
	And I press "Register"
Then I should see "Name*is not available"
Then I should see "User name*is not available"
Examples:
| word1			|
| Admin			|
| Superuser	|
| webMaster	|

@register
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
	And the "I would like to forward my internal mail to my external." checkbox should be checked
When I fill in 'user_name' with "prince_philip"
Then the 'user_name' field should contain "prince_philip"
When I fill in 'name' with "Prince Philip"
	And I fill in 'nationality' with "Swedish"
	And I choose "female"
	And I fill in 'password' with "secret"
	And I fill in 'password_confirmation' with "secret"
	And I uncheck "I would like to forward my internal mail to my external."
	And I press 'register'
Then I should be redirected to the error users page
	And the "I would like to forward my internal mail to my external." checkbox should not be checked
When I fill in 'name_hurigana' with "プリンス　ヒリプ"
	And "" should be selected in "user_occupation"
	And "" should be selected in "user_age"
	And I check "I would like to forward my internal mail to my external."
	And I press 'register'
Then I should be redirected to the events page
	And a user should exist with username: "prince_philip", email: "prince@docomo.ne.jp", nationality: "Swedish", name: "Prince Philip", name_hurigana: "プリンス　ヒリプ", roles_mask: 48, male: false, language: "en", occupation: "", tel: "", age: "", invitation_limit: 0, info_update: true
	And I should see 'users.notice.new_registration'
	And I should see "Events"
	And a mail should exist with sender: user "johan", subject: "registered#user", message: "users.registered#Mafumafu"

@edit_user
Scenario: A user can not unset certain attributes that were set in an event registration
Given a user exists with username: "kurosawa", role: "registrant", language: "en", occupation: "e1", age: "age_10", occupation: "reg_e1"
	And a user is logged in as "kurosawa"
	And an event: "christmas" exists with title_en: "Christmas Party"
	And a registrant exists with user: that user, event: that event
When I follow "Edit Profile"
Then "Exchange Student" should be selected in "user_occupation"
	And "user_occupation" should have a blank option
	And "10's" should be selected in "user_age"
	And "user_age" should have no blank option
	And the "I would like to forward my internal mail to my external." checkbox should be checked
When I select "Japanese" from "In which language would you like this site to be?*"
	And I press "Update"
	And I should see "Successfully updated user." as notice flash message
	And I follow "ﾌﾟﾛﾌｨｰﾙ編集"
Then "" should be selected in "user_occupation"	
	And "10代" should be selected in "user_age"
	And "user_age" should have no blank option
When I select "英語" from "このサイトはどんな言語で利用する？*"
	And I press "更新"
	And I follow "Edit Profile"
Then "Exchange Student" should be selected in "user_occupation"
	And "user_occupation" should have a blank option
	And "10's" should be selected in "user_age"
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

@pending
Scenario: Klargoer vad som aer foer och efternamn (NOT IMPLEMENTED)

@pending	
Scenario: Nationality drop-down (NOT IMPLEMENTED)

@pending
Scenario: Avatar strular vid registreringoegonblicket (NOT IMPLEMENTED)

@pending
Scenario: Not be able to enter a 20+ digit number as telephone number (NOT IMPLEMENTED)

















