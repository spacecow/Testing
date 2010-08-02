When /^I within "([^\"]*)", select "([^\"]*)" from "([^\"]*)"$/ do |scope, value, field|
  within "##{scope}" do |element|
  	element.select(value, :from => field)
	end
end

Then /^within #{capture_model}, "([^\"]*)" should be selected in "([^\"]*)"$/ do |model, option_text,select_id|
	scope = model( model ).class.to_s.downcase + "_" + model( model ).id.to_s
	within "##{scope}" do |element|
	  field = element.field_with_id(select_id) 
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
end

Then /^within "([^\"]*)", "([^\"]*)" should be selected in "([^\"]*)"$/ do |scope, option_text,select_id|
	within "##{scope}" do |element|
	  field = element.field_with_id(select_id) 
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

Then /^"(.*)" should be selected in the "(.*)" (?:box|field|menu)$/ do |option_text,select_id| 
  begin
  	field = field_labeled(select_id) 
	rescue Webrat::NotFoundError
		field = field_with_id(select_id)
	end
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
