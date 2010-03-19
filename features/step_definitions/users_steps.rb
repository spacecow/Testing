When /^I change password with #{capture_model}$/ do |name|
  token = find_model(name)[0].token
	When "I go to path \"/change_password/#{token}\""
end

Then /^the page should have no "([^\"]*)" section$/ do |section|
	assert_have_no_xpath("//div[@class='#{section}']")
end

#---------------------- Confirm Page

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

#---------------------- Teacher Courses Page

Then /^I should see courses "([^\"]*)" within the form$/ do |text|
	Then "I should see \"#{text}\" in the string fields within \"fieldset.form\""
end

When /^I check course (\d+)$/ do |index|
	field_with_id( "user_courses_teachers_attributes_#{index}_chosen" ).check
end

When /^I uncheck course (\d+)$/ do |index|
	field_with_id( "user_courses_teachers_attributes_#{index}_chosen" ).uncheck
end

Then /^course (\d+) should be checked$/ do |index|
  field_with_id( "user_courses_teachers_attributes_#{index}_chosen" ).should be_checked
end

Then /^course (\d+) should not be checked$/ do |index|
  field_with_id( "user_courses_teachers_attributes_#{index}_chosen" ).should_not be_checked
end


Then /^I fill in the cost with "([^\"]*)" for course (\d+)$/ do |cost, index|
	field = field_with_id( "user_courses_teachers_attributes_#{index}_cost" )
	fill_in(field, :with => cost)
end

When /^I browse to the (teachers|students) page$/ do |category|
	When "I go to the users page"
	And "I select \"#{category.capitalize}\" from \"Sort\""
	And "I press \"Go!\""
end

When /^I browse to the (teacher|student) courses page for #{capture_model}$/ do |category, user|
	When "I browse to the #{category}s page"
	And "I follow \"Courses\" within #{user}"
end

Then /^I should automatically browse to the (teachers|students) page$/ do |category|
	Then "I should be redirected to the users page"
	And "\"#{category.capitalize}\" should be selected in the \"Sort\" field"
end

#--------------------------------------

Then /^I should see "([^\"]*)" in the string fields within "([^\"]*)"$/ do |text, scope|
  response.body.should have_selector( "#{scope} li.string input" ) do |content|
		content.map{|e| e['value']}.join(', ').should contain(text)	
	end
end
