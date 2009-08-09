SALT = "NaCl" unless defined?( SALT )

Given /^the following course records?$/ do |table|
  table.hashes.each do |hash|
  	Factory( :course,hash )
  end
end

Given /^I have courses titled "(.+)"$/ do |titles|
  titles.split(', ').each do |title|
  	Course.create!( :name=>title )	
  end
end

When /^I follow "([^\"]*)" in the row containing "([^\"]*)"$/ do |link, text|
	course = Course.find_by_name( text )
	within ".course_#{course.id}" do
		click_link link
	end
end

Then /^I should have ([0-9]+) courses?$/ do |count|
  Course.count.should == count.to_i
end

Given /^I have no courses$/ do
  Course.delete_all
end

Then /^course "([^\"]*)" should have ([0-9]+) teachers?$/ do |name,no|
	Course.find_by_name( name ).teachers.count.should == no.to_i
end

Then /^course "([^\"]*)" should have ([0-9]+) students?$/ do |name,no|
	Course.find_by_name( name ).students.count.should == no.to_i
end

Given /^I follow "([^\"]*)" within course "([^\"]*)"$/ do |link,scope|
  within ".#{scope}" do
		click_link link
	end
end































