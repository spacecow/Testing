every :reboot do
	command "chmod +x /home/deploy/app/staff/current/script/runner"
	rake "jobs:work"
end

every 1.day, :at => '8:00 pm' do
  runner "SystemMailer.daily_staff_reminder_from_automagic_johan"
end

every 1.day, :at => '4:00 am' do
  runner "SystemMailer.next_working_days_teacher_reminder_as_yoyaku_test"
end

every :friday, :at => '23:00 pm' do
	runner "Klass.generate_classes_for_reservation"
end

every :friday, :at => '23:30 pm' do
	runner "SystemMailer.reservable_classes_information"
end