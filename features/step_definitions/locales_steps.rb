When /^I follow '([^\']*)'$/ do |link|
  click_link I18n.translate( link )
end

When /^I follow '([^\']*)' in the row containing "([^\']*)"$/ do |link, text|
	course = Course.find_by_name( text )
	within ".course_#{course.id}" do
		click_link I18n.translate( link )
	end
end

When /^I fill in '([^\']*)' with "([^\"]*)"$/ do |field, value|
  fill_in(I18n.translate( field ), :with => value) 
end

When /^I press '([^\']*)'$/ do |button|
  click_button(I18n.translate( button ))
end

When /^I select "([^\"]*)" as the '([^\"]*)' date$/ do |date, date_label|
  select_date(date, :from => I18n.t('date_label'))
end

Then /^I should see '([^\']*)'$/ do |text|
  response.should contain(I18n.translate( text ))
end

Then /^I should see "([^\']*)"'([^\']*)'$/ do |text1,text2|
  response.should contain(text1+I18n.translate( text2 ))
end

Then /^I should see "([^\']*)"'([^\']*)''([^\']*)'$/ do |text1,text2,text3|
  response.should contain(text1+I18n.translate( text2 )+I18n.translate( text3 ))
end

Then /^I should see '([^\"]*)'"([^\"]*)"$/ do |text1,text2|
	response.should contain(I18n.translate( text1 )+text2 )
end
Then /^I should see '([^\"]*)''([^\"]*)'$/ do |text1,text2|
	response.should contain(I18n.translate( text1 )+I18n.translate( text2 ))
end

Then /^I should not see '([^\"]*)'"([^\"]*)"$/ do |text1,text2|
	response.should_not contain(I18n.translate( text1 )+text2 )
end


Then /^I should not see '([^\']*)'$/ do |text|
  response.should_not contain(I18n.translate( text ))
end

Then /^I should not see "([^\']*)"'([^\']*)'$/ do |text1,text2|
  response.should_not contain(text1+I18n.translate( text2 ))
end

Then /^I should not see "([^\']*)"'([^\']*)''([^\']*)'$/ do |text1,text2,text3|
  response.should_not contain(text1+I18n.translate( text2 )+I18n.translate( text3 ))
end

When /^I select "([^\"]*)" from '([^\"]*)'$/ do |value, field|
  select(value, :from => I18n.translate( field ))
end

When /^I follow '([^\"]*)' within "([^\"]*)"$/ do |link, text|
  within ".#{text}" do |scope|
		scope.click_link I18n.translate(link)
	end
end

Then /^I should see '([^\"]*)' within "([^\"]*)"$/ do |text,scope_string|
  within ".#{scope_string}" do |scope|
		scope.should contain( I18n.translate( text ))
	end
end

Then /^I should see "([^\"]*)"'([^\"]*)' within "([^\"]*)"$/ do |text1,text2,scope_string|
  within ".#{scope_string}" do |scope|
		scope.should contain( text1+I18n.translate( text2 ))
	end
end

Then /^I should see '([^\"]*)'"([^\"]*)" within "([^\"]*)"$/ do |text1,text2,scope_string|
  within ".#{scope_string}" do |scope|
		scope.should contain( I18n.translate( text1 ) + text2 )
	end
end

Then /^I should not see '([^\"]*)' within "([^\"]*)"$/ do |text,scope_string|
  within ".#{scope_string}" do |scope|
		scope.should_not contain( I18n.translate( text ))
	end
end

Then /^I should not see "([^\"]*)"'([^\"]*)' within "([^\"]*)"$/ do |text1,text2,scope_string|
  within ".#{scope_string}" do |scope|
		scope.should_not contain( text1+I18n.translate( text2 ))
	end
end


When /^I check '([^\"]*)'$/ do |field|
  check(I18n.translate( field )) 
end

When /^the '([^\"]*)' checkbox should be checked$/ do |label|
  field_labeled( I18n.translate( label )).should be_checked
end

When /^the '([^\"]*)' checkbox should not be checked$/ do |label|
  field_labeled( I18n.translate( label )).should_not be_checked
end

When /^the "([^\"]*)"'([^\"]*)' checkbox should be checked$/ do |label1,label2|
  field_labeled( label1+I18n.translate( label2 )).should be_checked
end

When /^I choose '([^\"]*)'$/ do |field|
  choose( I18n.t( field ))
end

Then /^the '([^\"]*)' field should contain "([^\"]*)"$/ do |field, value|
  field_labeled( I18n.t( field )).value.should =~ /#{value}/
end

Then /^the '([^\"]*)' field should be empty$/ do |field|
  field_labeled( I18n.t( field )).value.should be_nil
end

Then /^the '([^\"]*)' field should not contain "([^\"]*)"$/ do |field, value|
  field_labeled( I18n.t( field )).value.should_not =~ /#{value}/
end

When /^I attach the file at "([^\"]*)" to '([^\"]*)'$/ do |path, field|
  attach_file( I18n.t( field ), path)
end