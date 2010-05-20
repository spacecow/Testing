every :reboot do
	command "chmod +x script/runner"
	rake "jobs:work"
end

every 1.day, :at => '9:00 pm' do
  runner "SystemMailer.daily_staff_reminder"
end
