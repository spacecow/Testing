Given /^the following attendance records?$/ do |table|
  table.hashes.each do |hash|
		Factory( :attendance,hash )
  end
end

Then /^I should have ([0-9]+) attendances?$/ do |count|
  Attendance.count.should == count.to_i
end