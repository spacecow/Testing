Then /^(?:I|they) should see "([^"]*?)" in the email body$/ do |text|
  text.gsub!(/#last_month/,(Time.zone.now-1.month).strftime("%B"))
  current_email.body.should include(text)
end

