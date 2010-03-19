Then /^there should be no "([^\"]*)" field$/ do |field|
  begin
  	field_labeled(field).should be_nil
  rescue Webrat::NotFoundError
  	true.should be_true
  end
end

Then /^I should see "([^\"]*)" as error message for (\w+) (\w+)$/ do |message, model, field|
  Then "I should see /^#{message}$/ within \"li##{model}_#{field}_input ul.errors li\""
end

Then /^I should see "([^\"]*)" as hint for (\w+) (\w+)$/ do |message, model, field|
  Then "I should see /^#{message}$/ within \"li##{model}_#{field}_input p.inline-hint\""
end

# -------------------------- SELECTIONS

When /^I select "([^\"]*)" from "([^\"]*)" within #{capture_model}$/ do |value, field, model|
	scope = model( model ).class.to_s.downcase + "_" + model( model ).id.to_s
	within "##{scope}" do |element|
  	element.select(value, :from => field)
  end
end

# -------------------------- EXISTING OBJECTS

Then /^I should (not )?see a button "([^\"]*)"$/ do |negative, label|
  Then "the xpath \"//input[@value='#{label}']\" should #{negative}exist"
end

Then /^I should (not )?see a field "([^\"]*)" for (.+)$/ do |negative, field, model|
  Then "the xpath \"//li[@id='#{model}_#{field.downcase}_input']\" should #{negative}exist"
end
