class TemplateClassesController < ApplicationController
  load_and_authorize_resource
  #before_filter :load_classes_and_times
  
  def add_course
  	TemplateClass.create!(
  		:day => params[ :template_day ],
  		:course_id => params[ :course_id ],
  		:start_time => params[ :start_time ],
  		:end_time => params[ :end_time ]
  	)
		redirect_to template_classes_path( :template_day => params[ :template_day ])
	end
  
  def index
		@template_day = params[ :template_day ] || Date.current.strftime( "%a" ).downcase
#    @template_klasses = TemplateClass.find_all_by_day( @template_day, :include => [ :course, :course_time, :classroom, { :teacher=>:person }])
		@template_classes = TemplateClass.find_all_by_day( @template_day, :include => :course )
    @template_groups = @template_classes.group_by{|e| e.course.category }
    @days = t( 'date.day_names' ).zip( TemplateClass::DAYS )
#
#		@classrooms = Classroom.all
#		@teachers = Teacher.find( :all, :include => :person )
#		@collision = {}
  end

  # GET /template_classes/1
  # GET /template_classes/1.xml
  def show
    @template_class = TemplateClass.find(params[:id])
  end

  def new
    @template_class = TemplateClass.new( :capacity => 0, :day => params[:template_day] )
#		@teachers = [] you should not be able to choose teacher before course has been chosen
		@days = t( 'date.day_names' ).zip( TemplateClass::DAYS )
		@template_course = params[:template_course]

		if @template_course.blank?
	  	@courses = sort_courses
		elsif @template_course.split.size > 1
			@template_class.course = Course.first( :conditions => ["name = ?",@template_course])
			@template_class.start_time = params[:start_time]
			@template_class.end_time = params[:end_time]
			@template_class.capacity = params[:capacity]
			@template_class.save
			redirect_to template_classes_path
		else
			@courses = Course.all( :conditions => ["name like (?)",@template_course+"%"], :order=>:name )
		end
  end

  def create
    @template_class = TemplateClass.new( params[ :template_class ] )
		@days = t( 'date.day_names' ).zip( TemplateClass::DAYS )
		@template_course = params[:template_course]
		
#		@teachers = [] you should not be able to choose teacher before course has been chosen
#		if !params[:template_class][:course_id].blank?
#			@teachers = Teacher.all(
#				:conditions=>["courses.name = ?", Course.find( params[:template_class][:course_id] ).name],
#			  :include=>[:person, :courses])    
#		end

		if @template_course.blank?
	  	@courses = sort_courses
		elsif @template_course.split.size > 1
			@courses = Course.all( :conditions => ["name = ?",@template_course])
		else
			@courses = Course.all( :conditions => ["name like (?)",@template_course+"%"], :order=>:name )
		end

    if @template_class.save
      flash[:notice] = t( 'notice.create_success', :object => t( :template_class ).downcase )
      #format.html { redirect_to( template_classes_path( :template_day=>@template_class.day )) }
      redirect_to template_classes_path
    else
      render :action => "new"
    end
  end


  def edit
    @template_class = TemplateClass.find(params[:id])
		@days = t( 'date.day_names' ).zip( TemplateClass::DAYS )
		@courses = Course.all
		#@teachers = Teacher.all(
		#	:conditions=>["courses.name = ?", Course.find( @template_class.course_id ).name],
		#  :include=>[:person, :courses])      		    
  end
  
  def update
    @template_class = TemplateClass.find(params[:id])
  	@days = t( 'date.day_names' ).zip( TemplateClass::DAYS )
    @courses = Course.all
    course_id = @template_class.course_id

    if @template_class.update_attributes(params[:template_class])          
      flash[:notice] = t( 'notice.update_success', :object => t( :template_class ).downcase )
    	if params[:redirect] == "courses"
    		redirect_to edit_course_path( @template_class.course_id )
			else
				redirect_to( template_classes_path( :template_day=>@template_class.day ))
			end
    else
      @template_class.update_attribute( :course_id, course_id )          
			#@teachers = Teacher.all(
			#	:conditions=>["courses.name = ?", Course.find( course_id ).name],
			#	:include=>[:person, :courses]) 
    	render :action => "edit"
    end
  end

  def destroy
#    @template_day = @template_class.day
    @template_class.destroy
    flash[:notice] = t('notice.delete_success', :object=>t(:template_class).downcase )
		redirect_to template_classes_path #(template_classes_path( :template_day=>@template_class.day )) }
  end

  def no_of_ten_minutes
    10
  end

private
	def sort_courses
  	@courses = []
  	@sorting = Sorting.new
  	@courses_groups = Course.all( :order=>:name ).group_by(&:category)
		@sorting.sort_in_mogi_order( @courses_groups.keys ).each do |key|
			@courses_groups[key].map{|course| @courses.push course }
		end
		@courses		
	end

  def load_classes_and_times
    @courses = Course.all
    @times = CourseTime.find( :all, :order=>'text' )
    @days = [['Choose a day'], ['Monday'], ['Tuesday'], ['Wednesday'], ['Thursday'], ['Friday'], ['Saturday'], ['Sunday']]
  end
  
  def find_schedule
    session[ :schedule ] ||= Schedule.new
  end
end

