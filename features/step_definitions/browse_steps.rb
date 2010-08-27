When /^I browse to the (.+) page for user: "([^\"]*)"$/ do |page, user|
  When "I go to the show page for user: \"#{user}\""
  And "I press \"#{I18n.t(page.gsub(/ /,'_'))}\""
end

When /^I browse to the (.+) page for user: "([^\"]*)" for "([^\"]*)"$/ do |page, user, interval|
  When "I go to the show page for user: \"#{user}\""
  And "I select \"#{interval}\" from \"Week\""
  And "I press \"#{I18n.t(page.gsub(/ /,'_'))}\""
end
