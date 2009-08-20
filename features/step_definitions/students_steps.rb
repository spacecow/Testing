Given /^the following student records?$/ do |table|
	table.hashes.each do |hash|
  	person_hash = {}
  	hash.keys.each do |key|
  		person_hash[key] = hash[key] unless key=="id"
  	end		
  	password = person_hash.delete "password"
  	person_hash["salt"] = SALT
  	person_hash["hashed_password"] = Person.encrypted_password( password, SALT )
  	person = Factory( :person,person_hash )

  	student_hash = {}
  	student_hash[:person_id] = person.id
  	student_hash[:id] = hash[:id] if hash[:id]
  	Factory( :student,student_hash )
  end
end

When /^I try to delete student "([^\"]*)"$/ do |user|
	post "/people/destroy", :id => Person.find_by_user_name( user ).id
	# Selenium
	# fill in "Search" with " "
end

Given /^that students? "([^\"]*)" (?:has|have) courses? "([^\"]*)"$/ do |users,courses|
  users.split(', ').map{|e| Student.user( e ).first}.each do |student|
	  courses.split(', ').each do |course|
	  	student.courses << Course.find_by_name( course )
	  end
	end
end

Given /^that student "([^\"]*)" has classe?s? "([^\"]*)"$/ do |username,classes|
  student = Student.user( username ).first
  classes.split(', ').each do |course|
  	if course.to_i > 0
  		student.klasses << Klass.find( course )
  	else
  		student.klasses << Factory( :klass, { :course_id => Course.find_by_name( course ).id })
  	end
  end
end

Given /^that student "([^\"]*)" has classe?s? "([^\"]*)" canceled$/ do |username,classes|
  student = Student.user( username ).first
  classes.split(', ').each do |course|
  	if course.to_i > 0
  		class_id = course
  		student.attendances.find_by_klass_id( class_id ).update_attribute( :cancel, 1 )
  	end
  end
end

Then /^students? "([^\"]*)" should have ([0-9]+) courses?$/ do |users,no|
	users.split(', ').map{|e| Student.user( e ).first}.each do |student|
		student.courses.count.should == no.to_i
	end
end

Then /^students? "([^\"]*)" should have courses? "([^\"]*)"$/ do |users,courses|
  users.split(', ').map{ |e| Student.user( e ).first }.each do |student|
	  courses.split(', ').each do |course|
	  	student.courses.include?( Course.find_by_name( course )).should == true
	  end
	end
end

Then /^student "([^\"]*)" should have ([0-9]+) classe?s?$/ do |username,no|
	Student.user( username ).first.klasses.count.should == no.to_i
end

Then /^I should have ([0-9]+) students?$/ do |count|
  Student.count.should == count.to_i
end

Then /^I should be retransfered to the "([^\"]*)" page of "([^\"]*)"$/ do |page,name|
	response.should contain( I18n.translate( page )+" - #{name}" )
end

Then /^I should see the "([^\"]*)" page of "([^\"]*)"$/ do |page,name|
  response.should contain( I18n.translate( page )+" - #{name}" )
end

When /^I multiselect students "([^\"]*)"$/ do |users|
	visit edit_multiple_students_path(
		:student_ids => users.split(', ').map{ |e| Student.user( e ).first }
	)
	#Seline code
end

When /^I multiselect no students$/ do
	When "I multiselect students \"\""
end

#- F - U - N - C - T - I - O - N - S -----------------------------------------------------
