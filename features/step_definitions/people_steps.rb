When /^I should have ([0-9]+) persons?$/ do |no|
  Person.count.should == no.to_i
end