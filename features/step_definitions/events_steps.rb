Then(/^I should see events table$/) do |table|
  table.diff!(table_at("#events").to_a)
end

Given /^I am registered for that event$/ do
	When "I go to the show page of that event"
		And "I press \"Apply\""
		And "I select \"Exchange Student\" from \"Occupation\""
		And "I select \"10's\" from \"Age\""
		And "I fill in \"Telephone Number\" with \"080-1234-5678\""
		And "I press \"Apply\""
end

When /^I select todo with #{capture_model} and #{capture_model}$/ do |user, comment|
  user_id = find_model(user)[0].id
  comment_id = find_model(comment)[0].id
	When "I go to path \"move_comment?move=todo&description=Fuck+Christmas!&user_id=#{user_id}&comment_id=#{comment_id}\""
end

