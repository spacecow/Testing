Given /^I have basic settings$/ do
	Setting.create!( :name=>'main', :people_per_page=>5, :language=>'en' )	
end