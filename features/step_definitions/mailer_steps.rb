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