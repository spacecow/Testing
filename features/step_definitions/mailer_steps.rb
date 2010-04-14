Then /^(?:I|they) should not see "([^"]*?)" in the email body$/ do |text|
  current_email.body.should_not include(text)
end

#---------------- System mailer

When /^the system sends out the weekly schedule to concerned teachers from "(.+)"$/ do |date|
	SystemMailer.weekly_teacher_schedule_from( date )
end

When /^the system sends out the weekly schedule to #{capture_model} from "(.+)"$/ do |teacher,date|
	SystemMailer.weekly_teacher_schedule_to_from( model( teacher ), date )
end

When /^the system sends out the daily teacher reminder to concerned teachers at "([^\"]*)"$/ do |date|
	SystemMailer.daily_teacher_reminder_at( date )
end

When /^the system sends out the daily teacher reminder to #{capture_model} at "([^\"]*)"$/ do |teacher,date|
	SystemMailer.daily_teacher_reminder_to_at( model( teacher ), date )
end

#........ Visuals

When /^I browse to the "(Daily Mail)" page for #{capture_model}(?: of "([^\"]*)")?$/ do |link, teacher, date|
	When "I browse to the teachers page"
	When "I follow \"#{link}\" within #{teacher}"
	And "I select \"#{date}\" as date" unless date.nil?
end

Then /^I should see the (daily teacher reminder) mail in (.+) within "([^\"]*)"$/ do |mail, language, scope|
	File.open "app/views/system_mailer/#{mail.gsub(/\s/,'_')}_in_#{language.downcase}.erb", 'r' do |f|
		f.readlines.each do |line|
			Then "I should see \"#{line}\" within \"#{scope}\"" unless line == "<%= @schedule %>\n"
		end
	end
end

When /^I select "([^\"]*)" as (teacher|language|type)$/ do |option, category|
	Then "I select \"#{option}\" from \"menu_#{category}\""
	And "I press \"Go!\""
end

Then /^"([^\"]*)" should be selected as (teacher|language|type)$/ do |option, category|
  And "\"#{option}\" should be selected in \"menu_#{category}\""
end
