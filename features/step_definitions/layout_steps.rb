Then /^I should see "([^\"]*)" as (notice|error) flash message$/ do |message,type|
  Then "I should see \"#{message}\" within \"div##{type}\""
end

Then /^I should see links "([^\"]*)" at the bottom of the page$/ do |options|
  Then "I should see options \"#{options}\" within \"div#links\""
end

When /^I follow "([^\"]*)" at the bottom of the page$/ do |link|
  click_link_within("div#links", link)
end

Then /^I should see "([^\"]*)" as title$/ do |title|
	Then "I should see \"#{title}\" within \"legend\""
end