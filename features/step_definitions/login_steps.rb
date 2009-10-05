Given /^I am logged in as "([^\"]*)"(?: with password "([^\"]*)")?$/ do |username, password|
	Given "I have main settings"
  	And "I log in as \"#{username}\" with password \"" + ( password || "secret" ) + "\""
end

Given /^I log in as "([^\"]*)"(?: with password "([^\"]*)")?$/ do |username, password|
	Given "I go to the login page"
  	And "I fill in \'login\.user_name\' with \"#{username}\""
  	And "I fill in \'login\.password\' with \"" + ( password || "secret" ) + "\""
  	And "I press \'login\.button\'"
end

Then /^I should be redirected to the "login" page$/ do
  response.should contain( I18n.translate( 'login.title' ))
end

#www.mysoju.com