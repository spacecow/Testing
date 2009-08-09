Given /^the following template klass records?$/ do |table|
  table.hashes.each do |hash|
  	template_hash = {}
  	hash.keys.each do |key|
  		template_hash[key] = hash[key] unless key=="course"
  	end
  	if hash[:course]
	  	course = Course.find_by_name( hash[:course] )
	  	template_hash[ :course_id ] = course.id
	  end
  	#day = template_hash.delete( "day" )
  	template_hash[ :day ] = ( hash[:day] == "current day" ? Date.current.strftime("%A") : hash[:day] ) if hash[:day]
  	Factory( :template_class,template_hash )
	end
end


#When /^I follow "([^\"]*)" in row no ([0-9]+) containing template klass with course "([^\"]*)" and time interval "([^\"]*)"$/ do |link, no, name, interval|
#  start_time = interval.split('~')[0]
#  end_time = interval.split('~')[1]
#	template = TemplateClass.find( :all,
#    :conditions => [ "course_id = courses.id and courses.name = ? and start_time = ? and end_time = ?", name, start_time, end_time ],
#    :include => :course
#  )[no.to_i-1]
#	within ".template_klass_#{template.id}" do
#		click_link link
#	end
#end
#
#Given /^I follow "([^\"]*)" in the row containing template klass with course "([^\"]*)" and time interval "([^\"]*)"$/ do |link, name, interval|
#  category = name.split[0]
#  level = name.split[1]
#  start_time = interval.split('~')[0].split(':').join
#  end_time = interval.split('~')[1].split(':').join
#	within ".template_klass_#{category}_#{level}_#{start_time}_#{end_time}" do
#		click_link link
#	end
#end

Given /^I should have ([0-9]+) template klasse?s?$/ do |count|
  TemplateClass.count.should == count.to_i
end

Given /^I should have ([0-9]+) teachers?$/ do |count|
  Teacher.count.should == count.to_i
end