Then /^(?:I|they) should not see "([^"]*?)" in the email body$/ do |text|
  current_email.body.should_not include(text)
end

#---------------- System mailer

When /^the system sends out the daily staff reminder to concerned teachers$/ do
	SystemMailer.daily_staff_reminder
end

When /^the system sends out the daily staff reminder to concerned teachers as (yoyaku|johan) test$/ do |test|
	SystemMailer.send( "daily_staff_reminder_as_#{test}_test".to_sym )
end

When /^the system sends out the daily staff reminder to concerned teachers from "Automagic Johan"$/ do
  SystemMailer.daily_staff_reminder_from_automagic_johan
end

When /^the system sends out the daily staff reminder to concerned teachers as (yoyaku|johan) test from "Automagic Johan"$/ do |test|
	SystemMailer.send( "daily_staff_reminder_as_#{test}_test_from_automagic_johan".to_sym )
end

When /^the system sends out the daily staff reminder to concerned teachers at "([^\"]*)"$/ do |date|
	SystemMailer.daily_staff_reminder_at( date )
end



When /^the system sends out the daily teacher reminder to concerned teachers$/ do
	SystemMailer.daily_teacher_reminder
end

When /^the system sends out the daily teacher reminder to concerned teachers as (yoyaku|johan) test$/ do |test|
	SystemMailer.send( "daily_teacher_reminder_as_#{test}_test".to_sym )
end

When /^the system sends out the daily teacher reminder to concerned teachers at "([^\"]*)"$/ do |date|
	SystemMailer.daily_teacher_reminder_at( date )
end

When /^the system sends out the daily teacher reminder to #{capture_model} at "([^\"]*)"$/ do |teacher,date|
	SystemMailer.daily_teacher_reminder_to_at( model( teacher ), date )
end




When /^the system sends out the daily student reminder to concerned students$/ do
	SystemMailer.daily_student_reminder
end

When /^the system sends out the daily student reminder to concerned students at "([^\"]*)"$/ do |date|
	SystemMailer.daily_student_reminder_at( date )
end

When /^the system sends out the daily student reminder to concerned students as (yoyaku|johan) test$/ do |test|
	SystemMailer.send( "daily_student_reminder_as_#{test}_test".to_sym )
end

When /^the system sends out the daily student reminder to concerned students from "Automagic Johan"$/ do
  SystemMailer.daily_student_reminder_from_automagic_johan
end

When /^the system sends out the daily student reminder to concerned students as (yoyaku|johan) test from "Automagic Johan"$/ do |test|
	SystemMailer.send( "daily_student_reminder_as_#{test}_test_from_automagic_johan".to_sym )
end



When /^the system sends out the weekly schedule to concerned teachers$/ do
  SystemMailer.next_weeks_teacher_schedule
end

When /^the system sends out the weekly schedule to concerned teachers as (yoyaku|johan) test$/ do |test|
  SystemMailer.send( "next_weeks_teacher_schedule_as_#{test}_test".to_sym )
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

When /^the system sends out next working day's teacher reminder to concerned teachers as (yoyaku|johan) test$/ do |test|
	SystemMailer.send( "next_working_days_teacher_reminder_as_#{test}_test".to_sym )
end

When /^the system sends out next working day's teacher reminder to concerned teachers at "([^\"]*)"$/ do |date|
	SystemMailer.next_working_days_teacher_reminder_at( date )
end



When /^the system sends out the last month's salary summary to concerned teachers$/ do
  SystemMailer.last_months_salary_summary
end

When /^the system sends out the last month's salary summary to concerned teachers as (yoyaku|johan) test$/ do |test| #'
  SystemMailer.send( "last_months_salary_summary_as_#{test}_test".to_sym )
end



When /^the system sends out information about reservable classes to concerned students at "([^\"]*)"$/ do |date|
  SystemMailer.reservable_classes_information_at( date )
end

When /^the system sends out information about reservable classes to concerned students at "([^\"]*)" as (yoyaku|johan) test$/ do |date,test|
  SystemMailer.send( "reservable_classes_information_as_#{test}_test_at".to_sym, date )
end

#........ Visuals

Then /^I should see a link to the reserve section for (user ".+") in the email body$/ do |user|
	user_id = model( user ).id
	Then "I should see \"http://www.reserve-gakuwarinet.com/staff/users/#{user_id}/reserve\" in the email body"
end

When /^I browse to the "(Daily Mail|Weekly Mail)" page for #{capture_model}(?: of "([^\"]*)")?$/ do |link, teacher, date|
	When "I browse to the teachers page"
	When "I follow \"#{link}\" within #{teacher}"
	And "I select \"#{date}\" as date in the select menu" unless date.nil?
end

Then /^I should see the (.+) mail in (.+) in the email body addressed to #{capture_model} from "(.+)"$/ do |mail, language, user, sender|
	File.open "app/views/system_mailer/#{mail.gsub(/\s/,'_')}_in_#{language.downcase}.erb", 'r' do |f|
		f.readlines.each do |line|
			if line.match(/@schedule/)
				#skip
			elsif line.match(/@name/)
				Then "I should see \"#{line.gsub(/<%= @name %>/,model(user).name)}\" in the email body" 
			elsif line.match(/@sender/)
				Then "I should see \"#{line.gsub(/<%= @sender %>/,sender)}\" in the email body" 
			else
				Then "I should see \"#{line}\" in the email body" 
			end
		end
	end
end

Then /^I should see the (.+) mail in (.+) in the email body(?: addressed to #{capture_model})?$/ do |mail, language, user|
	File.open "app/views/system_mailer/#{mail.gsub(/\s/,'_')}_in_#{language.downcase}.erb", 'r' do |f|
		f.readlines.each do |line|
			if line.match(/@name/)
				if user.nil?
					Then "I should see \"#{line.gsub(/<%= @name %>/,'')}\" in the email body" 
				else
					Then "I should see \"#{line.gsub(/<%= @name %>/,model(user).name)}\" in the email body" 
				end
			elsif line.match(/@sender/)
				Then "I should see \"#{line.gsub(/<%= @sender %>/,'Hitomi')}\" in the email body" 
			elsif line.match(/<%= @/);
			else
				Then "I should see \"#{line}\" in the email body" 
			end
		end
	end
end

Then /^I should see the (.+) mail in (.+) in the email body(?: from "(.+)")$/ do |mail, language, sender|
	File.open "app/views/system_mailer/#{mail.gsub(/\s/,'_')}_in_#{language.downcase}.erb", 'r' do |f|
		f.readlines.each do |line|
			if line.match(/@schedule/)
				#skip
			elsif line.match(/@name/)
				Then "I should see \"#{line.gsub(/<%= @name %>/,'')}\" in the email body" 
			elsif line.match(/@sender/)
				Then "I should see \"#{line.gsub(/<%= @sender %>/,sender)}\" in the email body" 
			else
				Then "I should see \"#{line}\" in the email body" 
			end
		end
	end
end

Then /^the "([^\"]*)" field should contain the (.+) mail in (english|japanese)$/ do |id, mail, language|
	File.open "app/views/system_mailer/#{mail.gsub(/\s/,'_')}_in_#{language.downcase}.erb", 'r' do |f|
		f.readlines.each do |line|
			line = line.gsub(/\(/,"\\(").gsub(/\)/,"\\)")
			if line.match(/@schedule/)
				#do nothing
			elsif line.match(/@name/)
				Then "\"#{id}\" should contain \"#{line.gsub(/<%= @name %>/,'').chomp+"\r"}\"" 
			elsif line.match(/@sender/)
				Then "\"#{id}\" should contain \"#{line.gsub(/<%= @sender %>/,'Hitomi').chomp+"\r"}\"" 
			else
				Then "\"#{id}\" should contain \"#{line.chomp+"\r"}\"" 
			end
		end
	end  
end

Then /^the "([^\"]*)" field should contain the (.+) mail in ([Ee]nglish|[Jj]apanese) in "(.+)"$/ do |id, mail, language, date|
	months = %w(~ January February March April May June July August September October November December)
	if date == "#last_month"
		last_month 	= months[(Time.zone.now-1.month).month]
		this_month 	= months[Time.zone.now.month]
		confirm_day	= (Time.zone.now.beginning_of_month + 5.day).strftime("%a").downcase
	else
		month_index   	= months.index( date.split[0] )
		last_month			= (language.downcase=="english" ? date.split[0] : "#{month_index}月")
		year						= date.split[1].to_i+month_index/12 || Time.zone.now.year
		this_month_i    = month_index%12+1
		this_month 			= (language.downcase=="english" ? months[this_month_i] : "#{this_month_i}月")
		day_of_the_week = Time.zone.parse("#{year}-#{this_month_i}-6").strftime("%w").to_i
		if language.downcase=="english"
			confirm_day = %w(sun mon tue wed thu fri sat)[day_of_the_week]
		elsif language.downcase=="japanese"
			confirm_day = %w(日 月 火 水 木 金 土)[day_of_the_week]
		end
	end
	File.open "app/views/system_mailer/#{mail.gsub(/\s/,'_')}_in_#{language.downcase}.erb", 'r' do |f|
		f.readlines.each do |line|
			line = line.gsub(/\(/,"\\(").gsub(/\)/,"\\)").chomp+"\r"
			line.gsub!(/<%= @last_month %>/,last_month) if line.match(/@last_month/)
			line.gsub!(/<%= @this_month %>/,this_month) if line.match(/@this_month/)
			line.gsub!(/<%= @confirm_day %>/,confirm_day) if line.match(/@confirm_day/)
			if line.match(/<%= @/);
			else
				Then "\"#{id}\" should contain \"#{line}\"" 
			end
		end
	end  
end

Then /^"([^\"]*)" should have options "([^\"]*)" in the select menu$/ do |id, options|
  Then "within \"select_menu\", \"#{id}\" should have options \"#{options}\""
end

#....... Menu

When /^I select "([^\"]*)" as (teacher|language|type|day) in the select menu$/ do |option, category|
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

Then /^"([^\"]*)" should be selected as (teacher|language|type|day) in the select menu$/ do |option, category|
  And "within \"select_menu\", \"#{option}\" should be selected in \"menu_#{category}\""
end

#------------------------------- Functions

def get_month( month )
	month_no = %w[empty January February March April May June July August September October November December].index( month )
	I18n.t( 'date.month_names' )[ month_no ]	
end