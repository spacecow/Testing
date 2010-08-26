When /^I browse to the reserve page for user: "([^\"]*)"$/ do |user|
  When "I go to the show page for user: \"#{user}\""
  And "I press \"Reserve\""
end

When /^I browse to the (.+) page for user: "([^\"]*)" for "([^\"]*)"$/ do |page, user, interval|
  When "I go to the show page for user: \"#{user}\""
  And "I select \"#{interval}\" from \"Week\""
  And "I press \"#{I18n.t(page.gsub(/ /,'_'))}\""
end
