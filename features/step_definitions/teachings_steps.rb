Given /^the following teaching records?$/ do |table|
  table.hashes.each do |hash|
		Factory( :teaching,hash )
	end
end

Given /^I should have ([0-9]+) teaching$/ do |no|
	Teaching.count.should == no.to_i
end