#-------------------- FLASH

Then /^I should see "([^\"]*)" as (notice|error) flash message$/ do |message,type|
  Then "I should see \"#{message}\" within \"div##{type}\""
end

#-------------------- LINKS

Then /^I should see links "([^\"]*)" at the bottom of the page$/ do |options|
  Then "I should see options \"#{options}\" within \"div#links\""
end

Then /^I should see links "([^\"]*)" within #{capture_model}$/ do |links, model|
  scope = get_scope( model )
  Then "I should see options \"#{links}\" within \"tr##{scope} td#links\""
end

When /^I follow "([^\"]*)" at the bottom of the page$/ do |link|
  click_link_within("div#links", link)
end

#-------------------- PAGE

Then /^I should see "([^\"]*)" as title$/ do |title|
	Then "I should see \"#{title}\" within \"legend\""
end

When /^I check #{capture_model}$/ do |model|
  scope = get_scope( model )
  within "##{scope}" do |element|
		element.check( "" )
	end
end

#-------------------- TABLE

Then /^I should (not )?see "([^\"]*)" within the (.+) table$/ do |negative, text, model|
  text.split(", ").each do |t|
  	Then "I should #{negative}see \"#{t}\" within \"table##{model}\""
  end
end

#-------------------- NAVIGATION BAR

When /^I follow "([^\"]*)" in the navigation bar$/ do |link|
	When "I follow \"#{link}\" within \"div#banner\""
end

Then /^I should not see "([^\"]*)" in the navigation bar$/ do |link|
	Then "I should not see \"#{link}\" within \"div#banner\""
end

#-------------------- USER NAVIGATION BAR

Then /^I should see commands "([^\"]*)" in the user navigation bar$/ do |commands|
	Then "I should see options \"#{commands}\" within \"div#user_nav\""
end

When /^I follow "([^\"]*)" in the user navigation bar$/ do |link|
	When "I follow \"#{link}\" within \"div#user_nav\""
end


#-------------------- XPATH

Then /^the xpath "([^\"]*)" should exist$/ do |xpath|
  assert_have_xpath( xpath )
end

Then /^the xpath "([^\"]*)" should not exist$/ do |xpath|
  assert_have_no_xpath( xpath )
end

#--------------------

def get_scope( model )
	model( model ).class.to_s.downcase + "_" + model( model ).id.to_s
end
