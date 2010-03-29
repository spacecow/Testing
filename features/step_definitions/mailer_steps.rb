Then /^(?:I|they) should not see "([^"]*?)" in the email body$/ do |text|
  current_email.body.should_not include(text)
end

#---------------- System mailer

When /^the system sends out schedule to concerned teachers from "(.+)"$/ do |date|
	SystemMailer.next_weeks_teacher_schedule_from( date )
end

When /^the system sends out the daily teacher reminder for "([^\"]*)"$/ do |date|
	SystemMailer.daily_teacher_reminder_for( date )
end
