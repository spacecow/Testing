Then /^I should have ([0-9]+) klasse?s?$/ do |count|
  Klass.count.should == count.to_i
end

Then /^teacher "([^\"]*)" should have ([0-9]+) klasse?s?$/ do |user,count|
  Klass.count( :all,
  	:conditions => ["people.user_name = ?",user ],
  	:include => { :teacher => :person }
  ).should == count.to_i
end

Given /^the following klass records?$/ do |table|
  table.hashes.each do |hash|
  	course_name = hash.delete( "course" )
  	if course_name
  		course = Course.find_by_name( course_name )
  		hash[ :course_id ] = course.id
  	end
  	user_name = hash.delete( "teacher" )
  	if user_name
	  	teacher = Teacher.find( :first,
	  		:conditions => [ "person_id = people.id and people.user_name = ?", user_name ],
	  		:include => :person
	    )
	  	hash[ :teacher_id ] = teacher.id
	  end
	  date = hash.delete( "date" )
  	hash[ :date ] = ( date == "current date" ? DateTime.current.strftime("%x") : date ) if date
  	Factory( :klass,hash )
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

Given /^I have no classes$/ do
  Klass.delete_all
end

Given /^the following class records?$/ do |table|
  table.hashes.each do |hash|
		date = hash.delete( "date" )
  	hash[ :date ] = ( date == "current date" ? DateTime.current.strftime("%x") : date ) if date
		Factory( :klass,hash )
	end
end

#Only works if only one class is assigned to that specific course
Then /^class "([^\"]*)" should have a teacher$/ do |name|
	Klass.first(
		:conditions => ["courses.name=?",name],
		:include => :course ).teacher.should_not be_nil
end
