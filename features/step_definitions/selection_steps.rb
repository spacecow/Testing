When /^I within "([^\"]*)", select "([^\"]*)" from "([^\"]*)"$/ do |scope, value, field|
  within "##{scope}" do |element|
  	element.select(value, :from => field)
	end
end