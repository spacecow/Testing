Given /^the following template [ck]lass records?$/ do |table|
  table.hashes.each do |hash|
  	template_hash = {}
  	hash.keys.map(&:to_sym).each do |key|
  		case
  			when key == :course
  				template_hash[:course_id] = Course.find_by_name( hash[:course] ).id
  			when key == :teacher
  				template_hash[:teacher_id] = Teacher.user( hash[:teacher] ).first.id
  			when key == :day
  				template_hash[:day] = ( hash[:day] == "current day" ?
  					DateTime.current.strftime("%A") :
  					hash[:day] )
  			else
  				template_hash[key] = hash[key]
  		end
  	end
  	Factory( :template_class,template_hash )
	end
end

#Given /^I have template classes "([^\"]*)"$/ do |courses|
#  Given "the following template class records", table(
#    ([ "course" ] + courses.split(', ')).map{|e| [e]}
#  )
#end
#
#Given /^template classe?s? "([^\"]*)" (?:has|have) teacher "([^\"]*)"$/ do |names, username|
#  names.split(', ').each do |name|
#  	get_template_class( name ).update_attribute( :teacher_id, Teacher.user( username ).first.id )
#  end
#end
#
#Given /^I should have ([0-9]+) template [ck]lasse?s?$/ do |count|
#  TemplateClass.count.should == count.to_i
#end
#
#Given /^I should have ([0-9]+) teachers?$/ do |count|
#  Teacher.count.should == count.to_i
#end
#
#Then /^I should have ([0-9]+) template classe?s? "([^\"]*)"$/ do |no, name|
#  TemplateClass.course_name( name ).size.should == no.to_i
#end

When /^I browse to the template classes page of "([^\"]*)"$/ do |day|
	When "I go to the template classes page"
	And "I select \"#{day}\" as day in the select menu"
end

#------ Select teacher

When /^I select "([^\"]*)" as teacher within template class "([^\"]*)"$/ do |teacher, model|
	When "I select \"#{teacher}\" from \"template_class_teacher_id\" within template class \"#{model}\""
end

When /^I set "([^\"]*)" as teacher within template class "([^\"]*)"$/ do |teacher, model|
	And "I select \"#{teacher}\" as teacher within template class \"#{model}\""
	And "I press \"OK\" within template class \"#{model}\""
end

#- F - U - N - C - T - I - O - N - S -----------------------------------------------------

def get_template_class( name )
	if name.to_i > 0
  	return TemplateClass.find( name )
  end
end