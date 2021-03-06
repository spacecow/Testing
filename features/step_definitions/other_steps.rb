Given /^a courses_student join model exists with course: "([^\"]*)", student: "([^\"]*)"$/ do |course, student|
	User.find_by_username( student ).student_courses << Course.find_by_name( course )
end

Then /^(\d+) teachers should exist$/ do |no|
	User.with_role( "teacher" ).size.should == no.to_i
end

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

When /^I reload the page$/ do
	reload
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
  URI.parse(current_url).path.should_not == path_to(page)
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

When /^I select "([^\"]*)" from dropmenus "([^\"]*)"$/ do |selections, menu|
  selections.split(', ').each_with_index do |selection,i|
	  When "I select \"#{selection}\" from \"#{menu}_#{i+1}i\""
	end
end

Then /^within "([^\"]*)", "([^\"]*)" should have options "([^\"]*)"$/ do |scope, select_id, options|
	#scope = model( model ).class.to_s.downcase + "_" + model( model ).id.to_s
	within "##{scope}" do |element|
	  field = element.field_with_id(select_id)
	  field.options.map{|e| e.element.inner_html.blank? ? "BLANK" : e.element.inner_html }.join(", ").should == options
	end  
end

Then /^within #{capture_model}, "([^\"]*)" should have options "([^\"]*)"$/ do |model, select_id, options|
	scope = model( model ).class.to_s.downcase + "_" + model( model ).id.to_s
	within "##{scope}" do |element|
	  field = element.field_with_id(select_id)
	  field.options.map{|e| e.element.inner_html.blank? ? "BLANK" : e.element.inner_html }.join(", ").should == options
	end  
end

Then /^"(.*)" should have options "(.*)"$/ do |select_id, options| 
  field = field_with_id(select_id)
  field.options.map{|e| e.element.inner_html.blank? ? "BLANK" : e.element.inner_html }.join(", ").should == options
end

Then /^the "(.*)" field should have options "(.*)"$/ do |select_id, options| 
  begin
    field = field_by_xpath("//select[@id='#{select_id}']")
  rescue Webrat::NotFoundError
    field = field_labeled(select_id) 
  end
  field.options.map{|e| e.element.inner_html.blank? ? "BLANK" : e.element.inner_html }.join(", ").should == options
end

Then /^"(.*)" should have no blank option$/ do |select_id| 
  !get_options_array( select_id ).grep(/BLANK/).empty?
end

Then /^"(.*)" should have a blank option$/ do |select_id| 
  get_options_array( select_id ).grep(/BLANK/).empty?
end

Then /^I should see options "([^\"]*)" within "([^\"]*)"$/ do |options, selector|
	response.body.should have_selector( selector ) do |content|
  	begin
	  	content.should have_selector( 'a' ) do |links|
				array = []
				links.map{|e| e.inner_html =~ (/alt="(.+?)"/); array.push $1}
				(links.map{|e| e.inner_html.size < 50 ? e.inner_html : nil}.compact |
					array.compact).join(', ').should == options
			end
		rescue Spec::Expectations::ExpectationNotMetError #no links
			options.should == ""
		end
	end
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

#Then /^I should see links "([^\"]*)" within #{capture_model}$/ do |links, model|
#  links.split(', ').each_with_index do |link,i|
#    if i==0
#      And "I should see \"#{link}\" within #{model}"
#    else
#      And "I should see \"| #{link}\" within #{model}"
#    end
#  end
#end

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

When /^I press "([^\"]*)" within "(.+)"$/ do |text, scope|
  within "##{scope}" do |element|
		element.click_button( text )
	end
end


Then /^the "([^\"]*)" field should be blank$/ do |field|
  field_labeled(field).value.should be_nil
end

# -----------------------------------------------------

def get_options_array( select_id )
	field = field_with_id( select_id ) 
	field.options.map{|e| e.element.inner_html.blank? ? "BLANK" : e.element.inner_html }
end

def get_scope( model )
	model( model ).class.to_s.downcase + "_" + model( model ).id.to_s
end



















