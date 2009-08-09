Given /^the following teacher records?$/ do |table|
  table.hashes.each do |hash|
  	person_hash = {}
  	hash.keys.each do |key|
  		person_hash[key] = hash[key]
  	end
  	password = person_hash.delete "password"
  	person_hash["salt"] = SALT
  	person_hash["hashed_password"] = Person.encrypted_password( password, SALT )
  	person = Factory( :person,person_hash )
  	  	
  	teacher_hash = {}
  	teacher_hash[:person_id] = person.id
  	teacher_hash[:id] = hash[:id] if hash[:id]
  	Factory( :teacher,teacher_hash )
  end
end

Given /^that teacher "([^\"]*)" has courses? "([^\"]*)"$/ do |username,courses|
  teacher = find_teacher( username )
  courses.split(', ').each do |course|
  	teacher.courses << Course.find_by_name( course )
  end
end

Given /^that teacher "([^\"]*)" has classe?s? "([^\"]*)"$/ do |username,classes|
  teacher = find_teacher( username )
  classes.split(', ').each do |course|
  	teacher.klasses << Factory( :klass, { :course_id => Course.find_by_name( course ).id })
  end
end

Then /^teacher "([^\"]*)" should have ([0-9]+) courses?$/ do |user,no|
	find_teacher( user ).courses.count.should == no.to_i
end

Then /^teacher "([^\"]*)" should have ([0-9]+) classe?s?$/ do |user,no|
	find_teacher( user ).klasses.count.should == no.to_i
end