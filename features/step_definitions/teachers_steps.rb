Given /^the following teacher records?$/ do |table|
  table.hashes.each do |hash|
  	person_hash = {}
  	hash.keys.each do |key|
  		person_hash[key] = hash[key] unless key=="id"
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

Given /^I have teachers? "([^\"]*)"$/ do |users|
	users.split(', ').each do |user|
		person_hash = {}
		person_hash[:user_name] = user
  	person_hash[:salt] = SALT
  	person_hash[:hashed_password] = Person.encrypted_password( "secret", SALT )
  	person = Factory( :person,person_hash )
  	Factory( :teacher,{ :person_id => person.id })
  end
end


Given /^teachers? "([^\"]*)" (?:has|have) courses? "([^\"]*)"$/ do |users,courses|
	users.split(', ').map{|e| find_teacher( e )}.each do |teacher|
	  courses.split(', ').each do |course|
	  	teacher.courses << Course.find_by_name( course )
	  end
	end
end

Given /^teacher "([^\"]*)" has classe?s? "([^\"]*)"$/ do |username,classes|
  teacher = find_teacher( username )
  classes.split(', ').each do |course|
  	if course.to_i > 0
  		teacher.klasses << Klass.find( course )
  	else #Creates a new class with that course
  		teacher.klasses << Factory( :klass, { :course_id => Course.find_by_name( course ).id })
  	end
  end
end

Given /^teacher "([^\"]*)" had classe?s? "([^\"]*)" yesterday$/ do |username,classes|
  teacher = find_teacher( username )
  classes.split(', ').each do |course|
  	teacher.klasses << Factory( :klass, {
  		:course_id => Course.find_by_name( course ).id,
  		:date => 1.day.ago })
  end
end

Then /^teachers? "([^\"]*)" should have ([0-9]+) courses?$/ do |users,no|
	users.split(', ').map{|e| find_teacher( e )}.each do |teacher|
		teacher.courses.count.should == no.to_i
	end
end

Then /^teachers? "([^\"]*)" should have courses? "([^\"]*)"$/ do |users,courses|
  users.split(', ').map{|e| find_teacher( e )}.each do |teacher|
	  courses.split(', ').each do |course|
	  	teacher.courses.include?( Course.find_by_name( course )).should == true
	  end
	end
end

Then /^teacher "([^\"]*)" should have ([0-9]+) classe?s?$/ do |user,no|
	find_teacher( user ).klasses.count.should == no.to_i
end

Then /^teacher "([^\"]*)" should have class "([^\"]*)"$/ do |username,klass|
  teacher = Teacher.user( username ).first
  if name.to_i > 0
		teacher.klasses.include?( Klass.find( name )).should == true
	end
end


When /^I try to delete teacher "([^\"]*)"$/ do |user|
	post "/people/destroy", :id => Person.find_by_user_name( user ).id
	# Selenium
	# fill in "Search" with " "
end

def find_teacher( user )
	Teacher.first(
		:conditions=>["people.user_name=?", user],
		:include=>:person )
end

Given /^I multiselect teachers "([^\"]*)"$/ do |names|
	visit edit_multiple_teachers_path(
		:teacher_ids => names.split(', ').map{ |e| Teacher.user( e ).first }
	)
	#Seline code
end


#Then /^teacher "([^\"]*)" should have ([0-9]+) klasse?s?$/ do |user,count|
#  Klass.count( :all,
#  	:conditions => ["people.user_name = ?",user ],
#  	:include => { :teacher => :person }
#  ).should == count.to_i
#end