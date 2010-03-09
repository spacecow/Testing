module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
		when /mypage/
			'/mypage'    
    
		when /the root page/
			'/'
    
		when /path "(.+)"/
			$1
	
		when /^the (?:error )?(.+?) page$/
      send "#{$1.downcase.gsub(' ','_')}_path"
        
		when /^the (?:error )?show page (?:for|of) (.+)$/
			polymorphic_path( model($1) )
			      
		when /^the edit page (?:for|of) (.+)$/
			edit_polymorphic_path( model($1) )

		when /^the (reserve|edit courses|edit role) page (?:for|of) (.+)$/
			path = $1
			params = $2.split(" on ")
			path = path.downcase.gsub(' ','_')
			mdl  = params[0]
			date = params.size == 1 ? "" : "?majballe=#{params[1].gsub('"','')}"
			polymorphic_path( model(mdl) )+"/#{path}#{date}"

#		when /^the delete page (?:for|of) (.+)$/
#			polymorphic_path( model($1) ), :method => :delete
			
#    when /the homepage/
#      '/'
#    when /the login page/
#    	login_path
#    when /the logout page/
#    	logout_path
#    	
#    when /the list of events/
#    	events_path	
#    
#    when /the new user error page/
#    	users_path
#    		
#    when /the list of settings/
#    	settings_path
#
#    when /the list of schedules/
#    	schedules_path
#    when /the new page of schedule/
#    	new_schedule_path
#
#    when /the list of classrooms/
#    	classrooms_path
#    when /the list of [ck]lasses/
#    	klasses_path
#    when /the list of course times/
#    	course_times_path
#    when /the list of courses/
#    	courses_path
#    when /the list of units/
#    	units_path
#    when /the "(.+)" list of classes/
#    	klasses_path( :date => DateTime.parse( $1 ))
#    when /the list of people/
#    	people_path
#    when /the list of students/
#    	students_path
#    when /the list of teachers/
#    	teachers_path
#    when /the list of template [ck]lasses/
#    	template_classes_path
#    when /the list of template_[ck]lasses/
#    	template_classes_path    	
#    when /the "(.+)" list of template [ck]lasses/
#    	template_classes_path( :template_day => $1 )
#    when /student ([0-9]+) reserve page/
#    	edit_klasses_student_path( $1 )
#    when /student ([0-9]+) course page/
#    	edit_courses_student_path( $1 )
#    when /student ([0-9]+) info page/
#    	student_path( Student.find($1) )
#    when /teacher ([0-9]+) course page/
#    	edit_courses_teacher_path( $1 )
#    when /teacher ([0-9]+) info page/
#    	teacher_path( Teacher.find($1) )
#		when /the multi course page of teacher "(.+)"/
#			edit_multiple_teachers_path
#		when /the multi course page of student "(.+)"/
#			edit_multiple_students_path
#
#		when /the edit page of class "(.+)"/
#			edit_klass_path( $1 )
#		when /the info page of class "(.+)"/
#			klass_path( Klass.find( $1 ))
#
#		when /the edit page of course "(.+)"/
#			edit_course_path( Course.find_by_name( $1 ))			
#
#		when /the info page of student "(.+)"/
#    	student_path( Student.user( $1 ).first )
#		when /the course page of student "(.+)"/
#    	edit_courses_student_path( 
#	    	Student.first(
#	    		:conditions=>["people.user_name=?", $1],
#	    		:include=>:person
#	    	)
#    	)
#		when /the reserve page (?:of|for) student "(.+)"/
#    	edit_klasses_student_path( 
#	    	Student.first(
#	    		:conditions=>["people.user_name=?", $1],
#	    		:include=>:person
#	    	)
#    	)
#
#		when /the course page of teacher "(.+)"/
#    	edit_courses_teacher_path( 
#    		Teacher.find(
#    			:first,
#    			:conditions=>["people.user_name=?", $1],
#    			:include=>:person
#    		)
#    	)    	
#    when /the info page of teacher "(.+)"/
#    	teacher_path( 
#    		Teacher.find(
#    			:first,
#    			:conditions=>["people.user_name=?", $1],
#    			:include=>:person
#    		)
#    	)    	
#	
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
