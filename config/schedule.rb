every :reboot do
	runner QueuedMailing.deliver_queued_with_notification_on_failure!
end