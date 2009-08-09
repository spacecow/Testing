module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      '/'
    when /the login page/
    	login_path
    when /the list of course times/
    	course_times_path
    when /the list of courses/
    	courses_path
    when /the list of classrooms/
    	classrooms_path
    when /the list of klasses/
    	klasses_path
    when /the list of people/
    	people_path
    when /the list of students/
    	students_path
    when /the list of teachers/
    	teachers_path
    when /the list of template klasses/
    	template_classes_path
    when /the list of template_klasses/
    	template_classes_path    	
    when /student ([0-9]+) reserve page/
    	edit_klasses_student_path( $1 )
    when /student ([0-9]+) course page/
    	edit_courses_student_path( $1 )
    when /student ([0-9]+) info page/
    	student_path( Student.find($1) )
    when /teacher ([0-9]+) course page/
    	edit_courses_teacher_path( $1 )
    when /teacher ([0-9]+) info page/
    	teacher_path( Teacher.find($1) )
		when /the reserve page of student "(.+)"/
    	edit_klasses_student_path( 
	    	Student.first(
	    		:conditions=>["people.user_name=?", $1],
	    		:include=>:person
	    	).id
    	)
		when /the course page of teacher "(.+)"/
    	edit_courses_teacher_path( 
    		Teacher.find(
    			:first,
    			:conditions=>["people.user_name=?", $1],
    			:include=>:person
    		).id
    	)
		when /the info page of teacher "(.+)"/
    	teacher_path( 
    		Teacher.find(
    			:first,
    			:conditions=>["people.user_name=?", $1],
    			:include=>:person
    		)
    	)    	
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
