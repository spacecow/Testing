Given 'I am logged in as "(.+)" AJAX' do |user|
  @browser.open('admin/login/')
  @browser.is_text_present( I18n.translate( 'login.title' )).should be_true
  @browser.type 'user_name', user
  @browser.type 'password', "secret"
  clickAndWait "commit"
  @browser.is_text_present( I18n.translate( 'klasses.listing' )).should be_true
end

When /^I choose "([^\"]*)" for class ([0-9]+) as student ([0-9]+)$/ do |name, class_no, student_no|
  selectAndWait( get_student_locator( class_no, student_no ), name )
end
	
When /^I select "([^\"]*)" for "([^\"]*)" class ([0-9]+) as teacher$/ do |name, category, class_no|
 	selectAndWait( get_teacher_locator( category, class_no ), name )
end

When /^I unselect teacher for "([^\"]*)" class ([0-9]+)$/ do |category, class_no|
 	When "I select \"\" for \"#{category}\" class #{class_no} as teacher"
end

When /^I move "([^\"]*)" from class ([0-9]+) to class ([0-9]+)$/ do |username, class_1, class_2|
  selectAndWait( get_student_locator( class_1, get_student_no( username, class_1 )), "Move to #{class_2}" )
end	

When /^I cancel "([^\"]*)" for class ([0-9]+)$/ do |username, class_no|
  selectAndWait( get_student_locator( class_no, get_student_no( username, class_no )), "Cancel" )
end	

When /^I delete "([^\"]*)" for class ([0-9]+)$/ do |username, class_no|
  selectAndWait( get_student_locator( class_no, get_student_no( username, class_no )), "Delete" )
end	

Then /^I should see "([^\"]*)" for class ([0-9]+) as student ([0-9]+)$/ do |name, class_no, student_no|
  @browser.get_selected_label( get_student_locator( class_no, student_no )).should == name
end

Then /^I should see teacher options "([^\"]*)" for "([^\"]*)" class ([0-9]+)$/ do |names, category, class_no|
	name_array = @browser.get_select_options( get_teacher_locator( category, class_no ))
	names.split(', ').each do |name|
		name_array.include?( name ).should be_true
	end
end

Then /^I should see no teacher options for "([^\"]*)" class ([0-9]+)$/ do |category, class_no|
  @browser.get_select_options( get_teacher_locator( category, class_no )).reject{|e| e==""}.empty?.should be_true
end
	
Then /^I should not see any students for class ([0-9]+)$/ do |class_no|
  @browser.is_element_present( get_student_locator( class_no, 1 )).should be_false
end

When /wait/ do
	sleep 10
end	

#----------------------------------------------------------------------------

def clickAndWait( locator )
  @browser.click locator
  page_load
end

def get_class( class_no )
  index = 1;
  course_klasses = Klass.all( :conditions=>[ "courses.name like (?)", "Java%" ], :include=>'course' )
  @time_groups = course_klasses.group_by{|e| e.time_interval }
  @time_groups.sort.each do |time, time_klasses_and_levels|
		time_klasses_and_levels.group_by{|e| e.course_level }.sort.each do |level,time_klasses|
			time_klasses.each do |klass,i|
				return klass if class_no.to_i == index
				index += 1
			end
		end
	end
end

def get_student_no( username, class_no )
	attendance = Attendance.find_by_student_id( Student.user( username ))
  get_class( class_no ).attendances.reject(&:cancel).index( attendance )+1
end

def get_student_locator( class_no, student_no )
	tr_i = ( 4+class_no.to_i ).to_s
	"//table[@id='JavaCourse']/tbody/tr[#{tr_i}]/td[@id='student_#{student_no}']/select"
end

def get_teacher_locator( category, class_no )
	tr_i = ( 4+class_no.to_i ).to_s
	"//table[@id='#{category}Course']/tbody/tr[#{tr_i}]/td[@id='teacher']/select"
end

def page_load( time='5000' )
	@browser.wait_for_page_to_load('5000')
end

def selectAndWait( locator, selection )
	@browser.select( locator, selection )
	page_load
end