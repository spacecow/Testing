#Then /^there should be no "([^\"]*)" field$/ do |field|
#  begin
#  	field_labeled(field).should be_nil
#  rescue Webrat::NotFoundError
#  	true.should be_true
#  end
#end

Then /^within "([^\"]*)", the "([^\"]*)" field should contain "([^\"]*)"$/ do |scope, field, value|
  within "##{scope}" do |element|
  	element.field_labeled(field).value.should =~ /#{value}/
	end
end

When /^I within "([^\"]*)", fill in "([^\"]*)" with "([^\"]*)"$/ do |scope, field, value|
  within "##{scope}" do |element|
  	element.fill_in(field, :with => value)
	end
end

Then /^the "([^\"]*)" field should be emtpy$/ do |field|
  Then "the \"#{field}\" field should contain \"\""
end

Then /^I should see "([^\"]*)" as error message for (\w+) (\w+)$/ do |message, model, field|
  Then "I should see /^#{message}$/ within \"li##{model}_#{field}_input ul.errors li\""
end

Then /^I should see "([^\"]*)" as hint for (\w+) (\w+)$/ do |message, model, field|
  Then "I should see /^#{message}$/ within \"li##{model}_#{field}_input p.inline-hint\""
end

Then /^"([^\"]*)" should contain "([^\"]*)"$/ do |field, value|
  field_with_id(field).value.should =~ /#{value}/
end

# -------------------------- SELECTIONS

When /^I select "([^\"]*)" from "([^\"]*)" within #{capture_model}$/ do |value, field, model|
	scope = model( model ).class.to_s.downcase + "_" + model( model ).id.to_s
	within "##{scope}" do |element|
  	#element.field_by_xpath( "//select[@id='#{field}']" ).set( value )
  	element.select( value, :from => field )
  end
end

# -------------------------- EXISTING OBJECTS

Then /^I should (not )?see a button "([^\"]*)"$/ do |negative, label|
  Then "the xpath \"//input[@value='#{label}']\" should #{negative}exist"
end

Then /^I should (not )?see a field "([^\"]*)"$/ do |negative, field|
  Then "the xpath \"//li[@id='#{field.downcase}']\" should #{negative}exist"
end

Then /^I should (not )?see a field "([^\"]*)" for (.+)$/ do |negative, field, model|
  Then "the xpath \"//li[@id='#{model}_#{field.downcase}_input']\" should #{negative}exist"
end

Then /^I should not see "([^\"]*)" within the form$/ do |text|
	success = false
	begin
	  response.body.should have_selector( "div.form" ) do |content|
			content.should_not contain(text)
			success = true
		end
	rescue Spec::Expectations::ExpectationNotMetError
		success.should be_true
	end
end

# -------------------------- CHECK BOXES

When /^I check the boxes within teachings "([^\"]*)"$/ do |models|
	models.split(', ').each do |model|
		When "I check the box within teaching \"#{model}\""
	end
end

When /^I check "([^\"]*)" within #{capture_model}$/ do |label, model|
	scope = model( model ).class.to_s.downcase + "_" + model( model ).id.to_s
	within "##{scope}" do |element|
		element.check( label )
	end
end

When /^I check the box within #{capture_model}$/ do |model|
	When "I check \"\" within #{model}"
end