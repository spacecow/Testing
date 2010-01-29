Then /^the "([^\"]*)" field should be empty$/ do |field|
  field_labeled(field).value.should be_nil
end
