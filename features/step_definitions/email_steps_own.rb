When /^(?:I|they|"([^"]*?)") opens? the email with subject "([^"]*?)"$/ do |address, subject|
  subject.gsub!(/#today/,"#{Time.zone.now.month}/#{Time.zone.now.day}")
  open_email(address, :with_subject => subject)
end