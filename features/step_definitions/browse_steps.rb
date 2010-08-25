When /^I browse to the reserve page for user: "([^\"]*)"$/ do |user|
  When "I go to the show page for user: \"#{user}\""
  And "I press \"Reserve\""
end

When /^I browse to the reserve page for user: "([^\"]*)" for "([^\"]*)"$/ do |user, interval|
  When "I go to the show page for user: \"#{user}\""
  And "I press \"Reserve\""
  And "I select \"#{interval}\" from \"Week\""
  And "I press \"Go!\""
end
