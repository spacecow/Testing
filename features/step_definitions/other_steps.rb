Then /^I should see todays date$/ do
  response.should contain( DateTime.current.strftime("%x"))
end

Then /^I should see todays day$/ do
  response.should contain( DateTime.current.strftime("%A"))
end

When /^I follow "([^\"]*)" within "([^\"]*)"$/ do |link, scope|
  within ".#{scope}" do
		click_link link
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