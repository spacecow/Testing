Given /^I am logged in as "([^\"]*)"(?: with password "([^\"]*)")?$/ do |username, password|
	visit login_path
  fill_in 'login.user_name', :with => username
  fill_in 'login.password', :with => password || "secret"
  click_button 'login.button'
end

Then /^I should be redirected to the "login" page$/ do
  response.should contain( I18n.translate( 'login.title' ))
end

#www.mysoju.com