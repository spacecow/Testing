Given /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |username, password|
	visit login_path
  fill_in "ユーザー名", :with => username
  fill_in "パスワード", :with => password
  click_button "ログイン"
end

Then /^I should be redirected to the "login" page$/ do
  response.should contain( I18n.translate( 'login.title' ))
end

#www.mysoju.com