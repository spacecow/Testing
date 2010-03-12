#--------------------- FORM

When /^I select "([^\"]*)" as teacher within klass "([^\"]*)"$/ do |teacher, model|
	When "I select \"#{teacher}\" from \"klass_teachings_attributes_0_teacher_id\" within klass \"#{model}\""
end

Then /^within klass: "([^\"]*)", the teacher field should have options "([^\"]*)"$/ do |model, options|
  Then "within klass: \"#{model}\", \"klass_teachings_attributes_0_teacher_id\" should have options \"#{options}\""
end

Then /^within klass: "([^\"]*)", "([^\"]*)" should be selected as teacher$/ do |model, teacher|
  Then "within klass: \"#{model}\", \"#{teacher}\" should be selected in \"klass_teachings_attributes_0_teacher_id\""
end

#---------------------

When /^I browse to the klasses page of "([^\"]*)"$/ do |date|
	When "I go to the klasses page"
	And "I select \"#{date.split[0]}\" from \"class_month\""
	And "I select \"#{date.split[1]}\" from \"class_day\""
	And "I select \"#{date.split[2]}\" from \"class_year\""
	And "I press \"Go!\""
end

Given /^the following [ck]lass records?$/ do |table|
  table.hashes.each do |hash|
  	klass_hash = {}
  	hash.keys.map(&:to_sym).each do |key|
  		case
  			when key == :course
  				klass_hash[:course_id] = Course.find_by_name( hash[:course] ).id
  			when key == :teacher
  				klass_hash[:teacher_id] = Teacher.user( hash[:teacher] ).first.id
  			when key == :date
  				klass_hash[:date] = ( hash[:date] == "current date" ?
  					DateTime.current.strftime("%x") :
  					hash[:date] )
  			else
  				klass_hash[key] = hash[key]
  		end
  	end
  	Factory( :klass,klass_hash )
	end
end

#Given /^the following class records?$/ do |table|
#  table.hashes.each do |hash|
#		date = hash.delete( "date" )
#  	hash[ :date ] = ( date == "current date" ? DateTime.current.strftime("%x") : date ) if date
#		Factory( :klass,hash )
#	end
#end

Given /^I have classe?s? "([^\"]*)"$/ do |courses|
  Given "the following klass records", table(
    ([ "course" ] + courses.split(', ')).map{|e| [e]}
  )
end

Given /^I have no classes$/ do
  Klass.delete_all
end

Given /^classe?s? "([^\"]*)" (?:has|have) teacher "([^\"]*)"$/ do |names, user_name|
  names.split(', ').each do |name|
  	get_class( name ).update_attribute( :teacher_id, Teacher.user( user_name ).first.id )
  end
end

Given /^classe?s? "([^\"]*)" (?:has|have) chosen students? "([^\"]*)"$/ do |names, users|
  names.split(', ').each do |name|
  	klass = get_class( name )
  	users.split(', ').each do |user_name|
	  	student = Student.user( user_name ).first
	  	klass.students << student
	  	klass.attendances.find_by_student_id( student.id ).update_attribute( :chosen, 1 )
	  end
  end
end

Given /^classe?s? "([^\"]*)" (?:has|have) canceled students? "([^\"]*)"$/ do |names, users|
  names.split(', ').each do |name|
  	klass = get_class( name )
  	users.split(', ').each do |user_name|
	  	student = Student.user( user_name ).first
	  	klass.students << student
	  	klass.attendances.find_by_student_id( student.id ).update_attributes({ :cancel=>1, :chosen=>1 })
	  end
  end
end


Given /^classe?s? "([^\"]*)" (?:has|have) student "([^\"]*)"$/ do |names, user_name|
  names.split(', ').each do |name|
  	get_class( name ).students << Student.user( user_name ).first
  end
end

When /^I follow "([^\"]*)" within klass ([0-9]+)$/ do |link, no|
  klass = Klass.all[no.to_i-1]
	within ".klass_#{klass.id}" do
		click_link link
	end
end

When /^I follow '([^\"]*)' within klass ([0-9]+)$/ do |link,no|
  klass = Klass.all[no.to_i-1]
	within ".klass_#{klass.id}" do
		click_link I18n.translate(link)
	end
end

When /^I select no teacher$/ do
  When "I select \"\" from 'teacher'"
end

Then /^I should have ([0-9]+) [ck]lasse?s?$/ do |count|
  Klass.count.should == count.to_i
end

Then /^I should have ([0-9]+) classe?s? "([^\"]*)"$/ do |no, name|
  Klass.course_name( name ).size.should == no.to_i
end

#Only works if only one class is assigned to that specific course
Then /^class "([^\"]*)" should have a teacher$/ do |name|
	Klass.first(
		:conditions => ["courses.name=?",name],
		:include => :course ).teacher.should_not be_nil
end

Then /^class "([^\"]*)" should have teacher "([^\"]*)"$/ do |klass,username|
  teacher = Teacher.user( username ).first
  if name.to_i > 0
  	Klass.find( name ).teacher.should == teacher
	end
end

Then /^class "([^\"]*)" should have student "([^\"]*)"$/ do |klass,username|
  student = Student.user( username ).first
  if name.to_i > 0
  	Klass.find( name ).students.include?( student ).shoudl == true
	end
end

#Only works if only one class is assigned to that specific course
Then /^class "([^\"]*)" should have ([0-9]+) students?$/ do |name,no|
	if name.to_i > 0
		klass_id = name
		Klass.find( klass_id ).students.count.should == no.to_i
	else
		Klass.first(
			:conditions => ["courses.name=?",name],
			:include => :course ).students.count.should == no.to_i
	end
end

Then /^I have ([0-9]+) classe?s? "([^\"]*)"$/ do |no, name|
  Klass.course_name( name ).size.should == no.to_i
end

Given /^I generate classes for reservation from "([^\"]*)"$/ do |date|
  Klass.generate_classes_for_reservation_from( date )
end

Given /^I generate classes for reservation$/ do
  Klass.generate_classes_for_reservation
end

#- F - U - N - C - T - I - O - N - S -----------------------------------------------------

def get_class( name )
	if name.to_i > 0
  	return Klass.find( name )
  end
end