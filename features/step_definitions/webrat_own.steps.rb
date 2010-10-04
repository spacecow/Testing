Then /^the "([^\"]*)" field should be empty$/ do |field|
  field_labeled(field).value.should be_nil
end

Then /^the "([^\"]*)" field should contain "([^\"]*)"$/ do |field, value|
  begin
    field_labeled(field).value.should =~ /#{value}/
  rescue Webrat::NotFoundError
    field_with_id(field).value.should =~ /#{value}/
  end
end
