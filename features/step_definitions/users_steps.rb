When /^I change password with #{capture_model}$/ do |name|
  token = find_model(name)[0].token
	When "I go to path \"/change_password/#{token}\""
end

Then /^the page should have no "([^\"]*)" section$/ do |section|
	assert_have_no_xpath("//div[@class='#{section}']")
end

When /^I browse to the (teachers|students) page$/ do |category|
	When "I go to the users page"
	And "I select \"#{category.capitalize}\" from \"Sort\""
	And "I press \"Go!\""
end

#----------------------Confirm page

When /^I (confirmed|declined) #{capture_model} for #{capture_model} from "([^\"]*)"$/ do |action, klass_model, user_model, date|
  klass = model( klass_model )
  user = model( user_model )
  index = Klass.all(
		:conditions=>["date >= ? and klasses.id = teachings.klass_id and teachings.teacher_id = ?", date, user.id],
		:include=>:teaching
		).sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}.
		  index( klass )
	field_with_id( "user_teachings_attributes_#{index}_confirm_#{action}" ).choose
end

Then /^I should see "([^\"]*)" within the confirmable section$/ do |text|
	response.body.should have_selector( "li.string input" ) do |content|
		content.map{|e| e['value']}.join(', ').should contain(text)	
	end
end

Then /^I should not see "([^\"]*)" within the confirmable section$/ do |text|
	success = false
	begin
	  response.body.should have_selector( "li.string input" ) do |content|
			content.map{|e| e['value']}.join(', ').should_not contain(text)
			success = true
		end
	rescue Spec::Expectations::ExpectationNotMetError
		success.should be_true
	end
end