Then(/^I should see events table$/) do |table|
  table.diff!(table_at("#events").to_a)
end

Given /^I am registered for that event$/ do
	When "I go to the show page of that event"
		And "I press \"Register\""
		And "I select \"Exchange Student\" from \"Occupation\""
		And "I select \"10's\" from \"Age\""
		And "I fill in \"Telephone Number\" with \"080-1234-5678\""
		And "I press \"Register\""
end



