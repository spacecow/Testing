Given /^a klass exists with todays date(?: with #{capture_fields})?$/ do |fields|
  if fields.nil?
  	Given "a klass exists with date: \"#{Time.zone.now.to_s.split[0]}\""
  else
  	Given "a klass exists with date: \"#{Time.zone.now.to_s.split[0]}\", #{fields}"
	end
end

Given /^a klass: "(.+)" exists with todays date(?: with #{capture_fields})?$/ do |name, fields|
  if fields.nil?
  	Given "a klass \"#{name}\" exists with date: \"#{Time.zone.now.to_s.split[0]}\""
  else
  	Given "a klass \"#{name}\" exists with date: \"#{Time.zone.now.to_s.split[0]}\", #{fields}"
	end
end

Given /^a klass exists with tomorrows date$/ do
  Given "a klass exists with date: \"#{(Time.zone.now+1.day).to_s.split[0]}\""
end

Given /^a klass exists a week from now$/ do
  Given "a klass exists with date: \"#{(Time.zone.now+7.day).to_s.split[0]}\""
end

Given /^a klass exists last month the (\d+)(?:st|nd|rd)(?: with #{capture_fields})?$/ do |date, fields|
  if fields.nil?
  	Given "a klass exists with date: \"#{((Time.zone.now-1.month).beginning_of_month+(date.to_i-1).day).to_s.split[0]}\""
  else
  	Given "a klass exists with date: \"#{((Time.zone.now-1.month).beginning_of_month+(date.to_i-1).day).to_s.split[0]}\", #{fields}"
	end
end

#======================== Index form

#------ Toggle status

When /^I press the (.+) button$/ do |button_id|
  field_with_id( button_id.gsub( / /,'_' )).click
end

Then /^the "(.+)" (?:button|field) should be disabled$/ do |label|
  begin
  	field_labeled( label ).disabled?.should be_true
	rescue Webrat::NotFoundError
		field_with_id( label ).disabled?.should be_true
	end
end

Then /^the "(.+)" (?:button|field) should not be disabled$/ do |label|
  begin
  	field_labeled( label ).disabled?.should_not be_true
  rescue Webrat::NotFoundError
  	field_with_id( label ).disabled?.should_not be_true
	end
end

Then /^the teacher select menu should be disabled within klass "([^\"]*)"$/ do |model|
	id = model( "klass: \"#{model}\"" ).id
	field_by_xpath( "//select[@id='klasses_#{id}_teaching_attributes_teacher_id']" ).disabled?.should be_true
end

Then /^I should see no (.+) button$/ do |button_id|
  assert_have_no_xpath("//input[@id='#{button_id}']")
end

Then /^I should see a (.+) button$/ do |button_id|
	assert_have_xpath("//input[@id='#{button_id.gsub(/ /,'_')}']")
end

Then /^I should see a (.+) button labeled "(.+)"$/ do |button_id, label|
	assert_have_xpath("//input[@id='#{button_id.gsub(/ /,'_')}' and @value='#{label}']")
end

#------ Select date

When /^I browse to the klasses page of "([^\"]*)"$/ do |date|
	When "I go to the klasses page"
	And "I select \"#{date}\" as date in the select menu"
end

Then /^I should automatically browse to the klasses page of "([^\"]*)"/ do |date|
	Then "I should be redirected to the klasses page"
	And "\"#{date}\" should be selected as date in the select menu"
end

#.. New/Edit form

Then /^"(\w+) (\d(?:\d)?), (\d{4})" should be selected as (.+) date$/ do |month, day, year, model|
	Then "\"#{year}\" should be selected in \"#{model}_date_1i\""
	And "\"#{month}\" should be selected in \"#{model}_date_2i\""
	And "\"#{day}\" should be selected in \"#{model}_date_3i\""
end

#------ Select student

Then /^I should see student "([^\"]*)" within klass "([^\"]*)"$/ do |student, klass|
	user = model( "user: \"#{student}\"" )
	klass = model( "klass: \"#{klass}\"" )
	attendance = klass.attendances.find_by_student_id(user.id)
  assert_have_xpath("//select[@id='klasses_#{klass.id}_attendances_#{attendance.id}\']")
end

Then /^I should see no students within klass "([^\"]*)"$/ do |klass_s|
	klass = model( "klass: \"#{klass_s}\"" )
	assert_have_no_xpath("//tr[@id='klass_#{klass.id}']/td[@id='student1']/select")
end

When /^I mark student "([^\"]*)" as "(Late|Cancel|Delete|Absent|In Time)" in klass "([^\"]*)"$/ do |student_s, command, klass_s|
	user = model( "user: \"#{student_s}\"" )
	klass = model( "klass: \"#{klass_s}\"" )	
	attendance = klass.attendances.find_by_student_id(user.id)
	When "I select \"#{command}\" from \"klasses_#{klass.id}_attendances_#{attendance.id}\""
	And "I press \"OK!\" within klass \"#{klass_s}\""
end

When /^I move student "([^\"]*)" from klass "([^\"]*)" to klass (\d)$/ do |student, klass, move_no|
	When "I prepare to move student \"#{student}\" from klass \"#{klass}\" to klass #{move_no}"
	And "I press \"OK!\" within klass \"#{klass}\""
end

When /^I prepare to move student "([^\"]*)" from klass "([^\"]*)" to klass (\d)$/ do |student, klass, move_no|
	user = model( "user: \"#{student}\"" )
	klass = model( "klass: \"#{klass}\"" )
	attendance = klass.attendances.find_by_student_id(user.id)
	When "I select \"Move to #{move_no}\" from \"klasses_#{klass.id}_attendances_#{attendance.id}\""
end

#------ Select teacher

When /^I select "([^\"]*)" as teacher within klass "([^\"]*)"$/ do |teacher, model|
	id = model( "klass: \"#{model}\"" ).id
	#klasses_23_teaching_attributes_teacher_id
	When "I select \"#{teacher}\" from \"klasses_#{id}_teaching_attributes_teacher_id\" within klass \"#{model}\""
end

Then /^within klass: "([^\"]*)", the teacher field should have options "([^\"]*)"$/ do |model, options|
	id = model( "klass: \"#{model}\"" ).id
  Then "within klass: \"#{model}\", \"klasses_#{id}_teaching_attributes_teacher_id\" should have options \"#{options}\""
end

Then /^within klass: "([^\"]*)", "([^\"]*)" should be selected as teacher$/ do |model, teacher|
	id = model( "klass: \"#{model}\"" ).id
  Then "within klass: \"#{model}\", \"#{teacher}\" should be selected in \"klasses_#{id}_teaching_attributes_teacher_id\""
end

Then /^I should see "([^\"]*)" as teacher within klass: "([^\"]*)"$/ do |teacher_s, klass_s|
  klass = model( "klass: \"#{klass_s}\"" )
  Then "I should see \"#{teacher_s}\" within \"tr#klass_#{klass.id} td#teacher\""
end

Then /^I should see no teacher within klass: "([^\"]*)"$/ do |klass_s|
  klass = model( "klass: \"#{klass_s}\"" )
  response.body.should have_selector( "tr#klass_#{klass.id} td#teacher" ) do |content|
		content.inner_html.strip.should == ""
	end
end

#---------------------

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

#------------------- Generate Classes

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