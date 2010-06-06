#Then /^(?:I|they) should see "([^"]*?)" in the email body$/ do |text|
#  text.gsub!(/#last_month/,(Time.zone.now-1.month).strftime("%B"))
#  current_email.body.should include(text)
#end

Then /^the email body should contain "([^"]*?)" in english$/ do |text|
  text.gsub!(/#last_month/, ( Time.zone.now-1.month ).strftime( "%B" ))
  text.gsub!(/#this_month/, Time.zone.now.strftime( "%B" ))
  text.gsub!(/#confirm_day/, ( Time.zone.now.beginning_of_month+5.day ).strftime( "%a" ))
  Then "I should see \"#{text}\" in the email body"
end

Then /^the email body should contain "([^"]*?)" in japanese$/ do |text|
  text.gsub!(/#last_month/, ( Time.zone.now-1.month ).month.to_s)
  text.gsub!(/#this_month/, Time.zone.now.month.to_s)
  #text.gsub!(/#confirm_day/, ( Time.zone.now.beginning_of_month+5.day ).strftime( "%a" ))
  text.gsub!(/#confirm_day/, %w(日 月 火 水 木 金 土)[(Time.zone.now.beginning_of_month+5.day).wday])
  Then "I should see \"#{text}\" in the email body"
end