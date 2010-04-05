Given /#{capture_model} is one of #{capture_model}'s (\w+)/ do |owned, owner, assoc|
   model!(owner).send(assoc) << model!(owned)
end 

Given /(\w+) "(.+)" is #{capture_model}'s (\w+)/ do |model, names, owner, assoc|
	names.split(", ").each do |name|
		Given "#{model} \"#{name}\" is one of #{owner}'s #{assoc}"
	end
end

Then /^"([^\"]*)" should be marked$/ do |word|
  within "div#japanese" do |scope|
		scope.should have_selector('font') do |marking|
			marking.inner_html.should == word
		end
	end  
end