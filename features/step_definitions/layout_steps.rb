#-------------------- FLASH

Then /^I should see "([^\"]*)" as (notice|error) flash message$/ do |message,type|
  Then "I should see \"#{message}\" within \"div##{type}\""
end

Then /^I should see no (notice|error) flash message$/ do |type|
  assert_have_no_xpath( "//div[@id='#{type}']" )
end


#-------------------- LINKS

Then /^I should see links "([^\"]*)" at the bottom of the page$/ do |options|
  Then "I should see options \"#{options}\" within \"div#links\""
end

Then /^I should see no links at the bottom of the page$/ do
  Then "I should see options \"\" within \"div#links\""
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

Then /^I should see "([^\"]*)" as second title$/ do |title|
  Then "I should see /^#{title}$/ within \"fieldset.intro legend\""
end

When /^I check #{capture_model}$/ do |model|
  scope = get_scope( model )
  within "##{scope}" do |element|
		element.check( "" )
	end
end

When /^I follow "([^\"]*)" within the ([^\"]*) section$/ do |link, section|
	When "I follow \"#{link}\" within \"div##{section}\""
end

Then /^I should (not )?see "([^\"]*)" within the ([^\"]*) section$/ do |neg, text, section|
	Then "I should #{neg}see \"#{text}\" within \"div##{section}\""
end

Then /^I should see "([^\"]*)" as title within "([^\"]*)"$/ do |title, selector|
	Then "I should see \"#{title}\" within \"#{selector} legend\""
end

Then /^I should see "([^\"]*)" as title within the ([^\"]*) section$/ do |title, section|
  Then "I should see \"#{title}\" as title within \"div##{section}\""
end

Then /^the page should have no "([^\"]*)" ([^\"]*) section$/ do |section, div|
	assert_have_no_xpath("//div[@#{div}='#{section}']")
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

Then /^the "([^\"]*)" id should not exist$/ do |id|
  Then "the \"#{id}\" id should not exist for \"div\""
end

Then /^the "([^\"]*)" id should not exist for "(.+)"$/ do |id, tag|
  assert_have_no_xpath( "//#{tag}[@id='#{id}']" )
end

#---------- SECTIONS

Then /^the page should have a "([^\"]*)" section$/ do |section|
  assert_have_xpath( "//div[@id='#{section}']" )
end

#---------- BUTTONS

Then /^I should see a button labeled "([^\"]*)"$/ do |label|
  assert_have_xpath("//input[@value='#{label}']")
end

Then /^I should not see a button labeled "([^\"]*)"$/ do |label|
  assert_have_no_xpath("//input[@value='#{label}']")
end



#--------------------

def get_scope( model )
	model( model ).class.to_s.downcase + "_" + model( model ).id.to_s
end
