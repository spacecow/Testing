Then /^I should see "([^\"]*)" as notice flash message$/ do |message|
  Then "I should see \"#{message}\" within \"div#notice\""
end

Then /^I should see links "([^\"]*)" at the bottom of the page$/ do |options|
  Then "I should see options \"#{options}\" within \"div#links\""
end

When /^I follow "([^\"]*)" at the bottom of the page$/ do |link|
  click_link_within("div#links", link)
end