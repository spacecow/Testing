Then /^(?:I|they) should not see "([^"]*?)" in the email body$/ do |text|
  current_email.body.should_not include(text)
end

#---------------- System mailer

When /^the system sends out the daily staff reminder to concerned teachers$/ do
	SystemMailer.daily_staff_reminder
end

When /^the system sends out the daily staff reminder to concerned teachers at "([^\"]*)"$/ do |date|
	SystemMailer.daily_staff_reminder_at( date )
end

When /^the system sends out the daily teacher reminder to concerned teachers at "([^\"]*)"$/ do |date|
	SystemMailer.daily_teacher_reminder_at( date )
end

When /^the system sends out the daily teacher reminder to #{capture_model} at "([^\"]*)"$/ do |teacher,date|
	SystemMailer.daily_teacher_reminder_to_at( model( teacher ), date )
end

When /^the system sends out the weekly schedule to concerned teachers at "(.+)"$/ do |date|
	SystemMailer.weekly_teacher_schedule_at( date )
end

When /^the system sends out the weekly schedule to #{capture_model} at "(.+)"$/ do |teacher,date|
	SystemMailer.weekly_teacher_schedule_to_at( model( teacher ), date )
end

When /^the system sends out next working day's teacher reminder to concerned teachers$/ do
	SystemMailer.next_working_days_teacher_reminder
end

When /^the system sends out next working day's teacher reminder to concerned teachers at "([^\"]*)"$/ do |date|
	SystemMailer.next_working_days_teacher_reminder_at( date )
end

#........ Visuals

When /^I browse to the "(Daily Mail|Weekly Mail)" page for #{capture_model}(?: of "([^\"]*)")?$/ do |link, teacher, date|
	When "I browse to the teachers page"
	When "I follow \"#{link}\" within #{teacher}"
	And "I select \"#{date}\" as date in the select menu" unless date.nil?
end

Then /^I should see the (.+) mail in (.+) in the email body$/ do |mail, language|
	File.open "app/views/system_mailer/#{mail.gsub(/\s/,'_')}_in_#{language.downcase}.erb", 'r' do |f|
		f.readlines.each do |line|
			Then "I should see \"#{line}\" in the email body" unless line == "<%= @schedule %>\n"
		end
	end
end

Then /^the "([^\"]*)" field should contain the (.+) mail in (.+)$/ do |id, mail, language|
	File.open "app/views/system_mailer/#{mail.gsub(/\s/,'_')}_in_#{language.downcase}.erb", 'r' do |f|
		f.readlines.each do |line|
			Then "\"#{id}\" should contain \"#{line.chomp+"\r"}\"" unless line == "<%= @schedule %>\n"
		end
	end  
end

Then /^"([^\"]*)" should have options "([^\"]*)" in the select menu$/ do |id, options|
  Then "within \"select_menu\", \"#{id}\" should have options \"#{options}\""
end

#....... Menu

When /^I select "([^\"]*)" as (teacher|language|type) in the select menu$/ do |option, category|
	Then "I within \"select_menu\", select \"#{option}\" from \"menu_#{category}\""
	And "I press \"Go!\""
end

When /^I select "(\w+) (\d(?:\d)?), (\d{4})" as date in the select menu$/ do |month, day, year|
	And "I within \"select_menu\", select \"#{get_month(month)}\" from \"menu_month\""
	And "I within \"select_menu\", select \"#{day}\" from \"menu_day\""
	And "I within \"select_menu\", select \"#{year}\" from \"menu_year\""
	And "I press \"Go!\""
end

Then /^"(\w+) (\d(?:\d)?), (\d{4})" should be selected as date in the select menu$/ do |month, day, year|
	And "within \"select_menu\", \"#{get_month(month)}\" should be selected in \"menu_month\""
 	And "within \"select_menu\", \"#{day}\" should be selected in \"menu_day\""
 	And "within \"select_menu\", \"#{year}\" should be selected in \"menu_year\""
end

Then /^"([^\"]*)" should be selected as (teacher|language|type) in the select menu$/ do |option, category|
  And "within \"select_menu\", \"#{option}\" should be selected in \"menu_#{category}\""
end

#------------------------------- Functions

def get_month( month )
	month_no = %w[empty January February March April May June July August September October November December].index( month )
	I18n.t( 'date.month_names' )[ month_no ]	
end