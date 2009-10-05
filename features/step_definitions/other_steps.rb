Given /^not implemented$/ do
	false.should be_true
end

Then /^I should see (todays|yesterdays) (day|date)$/ do |day,cat|
  hash = {}
  hash["todays"] = DateTime.current
  hash["yesterdays"] = 1.day.ago
  text = hash[day].strftime( cat=="date" ? "%x" : "%A" )
	response.should contain( text )
end

When /^I follow "([^\"]*)" within "([^\"]*)"$/ do |link, scope|
  within ".#{scope}" do
		click_link link
	end
end

Then /^I should see (todays|yesterdays) (day|date) within "([^\"]*)"$/ do |day,cat,scope_string|
  hash = {}
  hash["todays"] = DateTime.current
  hash["yesterdays"] = 1.day.ago
  text = hash[day].strftime( cat=="date" ? "%x" : "%A" )
  within ".#{scope_string}" do |scope|
		scope.should contain( text )
	end
end

Then /^I should see "([^\"]*)" within "([^\"]*)"$/ do |text,scope_string|
  within ".#{scope_string}" do |scope|
		scope.should contain( text )
	end
end

Then /^I should not see "([^\"]*)" within "([^\"]*)"$/ do |text,scope_string|
  within ".#{scope_string}" do |scope|
		scope.should_not contain( text )
	end
end

Then /^I should be redirected to (.+)$/ do |page|
  URI.parse(current_url).path.should == path_to(page)
end

Then /^I should see a notice "([^\"]*)"$/ do |mess|
  flash[:notice].should == mess
end

Then /^I should see an error "([^\"]*)"$/ do |mess|
  flash[:error].should contain( mess )
end

Then /^I should see an error '([^\"]*)'$/ do |mess|
  flash[:error].should contain( I18n.translate( mess ))
end

Then /^I should have a tag "([^\"]*)"$/ do |label|
  assert_have_selector( label )
end

Then /^I should not have a tag "([^\"]*)"$/ do |label|
  assert_have_no_selector( label )
end
