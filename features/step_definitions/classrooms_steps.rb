Given /^I have classrooms titled "(.+)"$/ do |titles|
  titles.split(', ').each do |title|
  	Classroom.create!( :name=>title )	
  end
end

Given /^I have the following classroom records?$/ do |table|
  table.hashes.each do |hash|
		Factory( :classroom,hash )
  end
end