Given /^I have main settings$/ do
	Setting.create!( :name=>'main', :people_per_page=>5, :units_per_schedule=>40, :language=>'en' )	
end

Given /^the list of people displays ([0-9]+) persons per page$/ do |no|
	Given "I go to the list of settings"
	And "I follow 'edit' within \"main\""
	And "I fill in 'people_per_page' with \"#{no}\""
	And "I press 'update'"
end