Then /^there should be no "([^\"]*)" field$/ do |field|
  begin
  	field_labeled(field).should be_nil
  rescue Webrat::NotFoundError
  	true.should be_true
  end
end

Then /^I should see "([^\"]*)" as (?:error message|hint) for (\w+) (\w+)$/ do |message, model, field|
  Then "I should see \"#{message}\" within \"li##{model}_#{field}_input\""
end