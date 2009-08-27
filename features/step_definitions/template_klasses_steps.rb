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

Given /^I have template classes "([^\"]*)"$/ do |courses|
  Given "the following template class records", table(
    ([ "course" ] + courses.split(', ')).map{|e| [e]}
  )
end

Given /^I should have ([0-9]+) template [ck]lasse?s?$/ do |count|
  TemplateClass.count.should == count.to_i
end

Given /^I should have ([0-9]+) teachers?$/ do |count|
  Teacher.count.should == count.to_i
end