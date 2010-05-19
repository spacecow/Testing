every :reboot do
	rake "jobs:work"
end

every 1.day, :at => '7:45 pm' do
  runner "SystemMailer.daily_staff_reminder"
end
