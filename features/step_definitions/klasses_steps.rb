Given /^the following klass records?$/ do |table|
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

Given /^the following class records?$/ do |table|
  table.hashes.each do |hash|
		date = hash.delete( "date" )
  	hash[ :date ] = ( date == "current date" ? DateTime.current.strftime("%x") : date ) if date
		Factory( :klass,hash )
	end
end

Given /^I have no classes$/ do
  Klass.delete_all
end

Given /^class "([^\"]*)" has teacher "([^\"]*)"$/ do |name, user_name|
  get_class( name ).update_attribute( :teacher_id, Teacher.user( user_name ).first.id )
end

Given /^class "([^\"]*)" has student "([^\"]*)"$/ do |name, user_name|
  get_class( name ).students << Student.user( user_name ).first
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

Then /^I should have ([0-9]+) klasse?s?$/ do |count|
  Klass.count.should == count.to_i
end

#Only works if only one class is assigned to that specific course
Then /^class "([^\"]*)" should have a teacher$/ do |name|
	Klass.first(
		:conditions => ["courses.name=?",name],
		:include => :course ).teacher.should_not be_nil
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

#- F - U - N - C - T - I - O - N - S -----------------------------------------------------

def get_class( name )
	if name.to_i > 0
  	return Klass.find( name )
  end
end