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

#When /^I follow "([^\"]*)" within "([^\"]*)"$/ do |link, scope|
#  within ".#{scope}" do
#		click_link link
#	end
#end

Then /^I should see (todays|yesterdays) (day|date) within "([^\"]*)"$/ do |day,cat,scope_string|
  hash = {}
  hash["todays"] = DateTime.current
  hash["yesterdays"] = 1.day.ago
  text = hash[day].strftime( cat=="date" ? "%x" : "%A" )
  within ".#{scope_string}" do |scope|
		scope.should contain( text )
	end
end

#Then /^I should see "([^\"]*)" within "([^\"]*)"$/ do |text,scope_string|
#  within ".#{scope_string}" do |scope|
#		scope.should contain( text )
#	end
#end

#Then /^I should not see "([^\"]*)" within "([^\"]*)"$/ do |text,scope_string|
#  within ".#{scope_string}" do |scope|
#		scope.should_not contain( text )
#	end
#end

Then /^I should be redirected to (.+)$/ do |page|
  URI.parse(current_url).path.should == path_to(page)
end

Then /^I should not be redirected to (.+)$/ do |page|
  URI.parse(current_url).path.should != path_to(page)
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

Then /^the "([^\"]*)" drop menu should contain "([^\"]*)"$/ do |field, title|
  value = Unit.find_by_title( title ).id
  field_labeled(field).value[0].should =~ /#{value}/
end

Then /^I should not see a button '([^\"]*)'$/ do |label|
  label = I18n.t( label ).gsub(/ /, '_')
  assert_have_no_xpath( "//input[@id='#{label}']" )
end

Then /^"(.*)" should be selected in "(.*)"$/ do |option_text,select_id| 
  field = field_with_id(select_id) 
  selected_value = field.value[0] 
  state = :nothing_selected 
  field.options.each do |option| 
    if option.element.to_html =~ /value="#{selected_value}"/ 
      state = :something_selected 
      option.element.inner_html.should == option_text 
    end
  end 
  state.should == :something_selected 
end
Then /^"(.*)" should not be selected in "(.*)"$/ do |option_text,select_id| 
  field = field_with_id(select_id) 
  selected_value = field.value[0] 
  state = :nothing_selected 
  field.options.each do |option| 
    if option.element.to_html =~ /value="#{selected_value}"/ 
      state = :something_selected 
      option.element.inner_html.should == option_text 
    end 
  end 
  state.should != :something_selected 
end

Then /^"(.*)" should have options "(.*)"$/ do |select_id, options| 
  field = field_with_id(select_id) 
  field.options.map{|e| e.element.inner_html.blank? ? "BLANK" : e.element.inner_html }.join(", ").should == options
end

Then /^"(.*)" should have no blank option$/ do |select_id| 
  !get_options_array( select_id ).grep(/BLANK/).empty?
end

Then /^"(.*)" should have a blank option$/ do |select_id| 
  get_options_array( select_id ).grep(/BLANK/).empty?
end

Then /^I should see links "([^\"]*)"$/ do |links|
  links.split(', ').each_with_index do |link,i|
    if i==0
      And "I should see \"#{link}\""
    else
      And "I should see \"| #{link}\""
    end
  end
end

Then /^I should see links "([^\"]*)" within #{capture_model}$/ do |links, model|
  links.split(', ').each_with_index do |link,i|
    if i==0
      And "I should see \"#{link}\" within #{model}"
    else
      And "I should see \"| #{link}\" within #{model}"
    end
  end
end

Then /^I should not see links "([^\"]*)" within #{capture_model}$/ do |links, model|
  links.split(', ').each_with_index do |link,i|
    if i==0
      And "I should not see \"#{link}\" within #{model}"
    else
      And "I should not see \"| #{link}\" within #{model}"
    end
  end
end

Then /^I should see "([^\"]*)" within #{capture_model}$/ do |text, model|
  scope = model( model ).class.to_s.downcase + "_" + model( model ).id.to_s
  #response_body.should have_selector( "div[id='#{scope}']" ) do |element|
  #  element.should contain( text )
  #end
	within "##{scope}" do |element|
		element.should contain( text )
	end  
end

Then /^I should not see "([^\"]*)" within #{capture_model}$/ do |text, model|
  scope = get_scope( model )
	within "##{scope}" do |element|
		element.should_not contain( text )
	end  
end

When /^I follow "([^\"]*)" within #{capture_model}$/ do |text, model|
  scope = get_scope( model )
  within "##{scope}" do |element|
		element.click_link text
	end
end

When /^I press "([^\"]*)" within #{capture_model}$/ do |text, model|
  scope = get_scope( model )
  within "##{scope}" do |element|
		element.click_button( text )
	end
end

# -----------------------------------------------------

def get_options_array( select_id )
	field = field_with_id( select_id ) 
	field.options.map{|e| e.element.inner_html.blank? ? "BLANK" : e.element.inner_html }
end

def get_scope( model )
	model( model ).class.to_s.downcase + "_" + model( model ).id.to_s
end



















