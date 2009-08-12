Given /^I am logged in as "([^\"]*)"/ do |user|
	@browser.open 'admin/login'
	@browser.is_text_present "Please log in"
	@browser.is_element_present 'user_name'
	@browser.type 'user_name', user
end