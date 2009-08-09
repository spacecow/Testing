Given /^the following courses student records?$/ do |table|
	table.hashes.each do |hash|
		Factory( :courses_student,hash )
	end
end

Then /^I should have ([0-9]+) courses_students?$/ do |count|
  CoursesStudent.count.should == count.to_i
end
