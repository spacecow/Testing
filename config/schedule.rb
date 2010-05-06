every :reboot do
	rake "jobs:work"
end

every 1.day, :at => '7:00 pm' do
  runner "SystemMailer.daily_teacher_reminder"
end
