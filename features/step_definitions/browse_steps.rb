When /^I browse to the (.+) page for user: "([^\"]*)"$/ do |page, user|
  When "I go to the show page for user: \"#{user}\""
  And "I press \"#{I18n.t(page.gsub(/ /,'_'))}\""
end

When /^I browse to the reserve page for user: "([^\"]*)" for "([^\"]*)"$/ do |user, interval|
  When "I go to the reserve page for user: \"#{user}\""
  And "I select \"#{interval}\" from \"Week\""
  And "I press \"Go!\""
#  When "I go to the show page for user: \"#{user}\""
#  And "I select \"#{interval}\" from \"Week\""
#  And "I press \"#{I18n.t(page.gsub(/ /,'_'))}\""
end
