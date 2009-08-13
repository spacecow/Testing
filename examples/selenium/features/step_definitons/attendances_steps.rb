Given /^I am logged in as "([^\"]*)"/ do |user|
	#@browser.open 'admin/login'
	#@browser.is_text_present "Please log in"
	#@browser.is_element_present 'user_name'
	#@browser.type "user_name", user
	Given "I go to the login page"
	fill_in I18n.translate('user_name'), :with => user
	#fill_in(field, :with => value) 
end