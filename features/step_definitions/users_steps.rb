When /^I change password with #{capture_model}$/ do |name|
  token = find_model(name)[0].token
	When "I go to path \"/change_password/#{token}\""
end

Then /^the page should have no "([^\"]*)" section$/ do |section|
	assert_have_no_xpath("//div[@class='#{section}']")
end

When /^I browse to the (teachers|students) page$/ do |category|
	When "I go to the users page"
	And "I select \"#{category.capitalize}\" from \"Sort\""
	And "I press \"Go!\""
end