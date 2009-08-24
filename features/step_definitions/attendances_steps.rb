Given /^the following attendance records?$/ do |table|
  table.hashes.each do |hash|
		Factory( :attendance,hash )
  end
end

Then /^I should have ([0-9]+) attendances?$/ do |count|
  Attendance.count.should == count.to_i
end

Given /^students "([^\"]*)" have class "([^\"]*)" chosen$/ do |users,klass|
	Attendance.all(
	:conditions=>["klass_id = ? and people.user_name in (?)", klass, users.split(', ')],
	:include=>{:student=>:person}).each do |attendance|
		attendance.update_attribute( :chosen, 1 )
	end
end