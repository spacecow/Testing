Then /^I should have ([0-9]+) students?$/ do |count|
  Student.count.should == count.to_i
end

Given /^the following student records?$/ do |table|
	table.hashes.each do |person_hash|
  	password = person_hash.delete "password"
  	person_hash["salt"] = SALT
  	person_hash["hashed_password"] = Person.encrypted_password( password, SALT )
  	
  	id = person_hash.delete "id"
  	person = Factory( :person,person_hash )
  	
  	student_hash = {}
  	student_hash[:person_id] = person.id
  	student_hash[:id] = id if id
  	Factory( :student,student_hash )
  end
end

Then /^I should be retransfered to the "([^\"]*)" page of "([^\"]*)"$/ do |page,name|
	response.should contain( I18n.translate( page )+" - #{name}" )
end

Then /^I should see the "([^\"]*)" page of "([^\"]*)"$/ do |page,name|
  response.should contain( I18n.translate( page )+" - #{name}" )
end