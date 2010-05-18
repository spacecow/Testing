class KlassesController < ApplicationController  
  before_filter :load_courses, :only => [:new, :create]
  load_and_authorize_resource

  def new
		if @class_course && @class_course.split.size > 1  #Duplicate class
			Klass.create!( params[:klass] )
			redirect_to klasses_path( :menu_year=>@klass.year, :menu_month=>@klass.month, :menu_day=>@klass.day ) and return
		end
		@klass = Klass.new(
			:capacity => nil,
			:date => params[:class_date].nil? ? nil : Time.zone.parse( params[:class_date] )
		)
  end

  def create
  	if @klass.save
  		flash[:notice] = t('notice.create_success', :object => t(:klass))
  		redirect_to klasses_path
		else
			render :action => :new	
		end
  end

  def edit
  end

  def update
		if @klass.update_attributes( params[:klass] )
  		flash[:notice] = t('notice.update_success', :object => t(:klass))
  		redirect_to klasses_path( :menu_year=>@klass.year, :menu_month=>@klass.month, :menu_day=>@klass.day )
		else
			render :action => :edit
		end
	end

  def destroy
    @klass = Klass.find( params[:id] )

#		error = association_delete_error_message(
#			@klass.attendances,
#			t('klasses.error.try_to_delete_klass_with_students' ))
										
#		if( !error.blank? )
#      flash[:error] = error
#      redirect_to :back #klasses_path( :date => params[:date] )
#      return
#    end
    
    @klass.destroy
    flash[:notice] = t('notice.delete_success', :object => t(:klass))
    redirect_to klasses_path( :menu_year=>@klass.year, :menu_month=>@klass.month, :menu_day=>@klass.day )
  end

  def index	
		@months = t('date.month_names').compact.zip((1..12).to_a )
		@days   =      (1..31).map{|e| e.to_s+t(:klass_day)}.zip((1..31).to_a )
		@years  = (2009..2020).map{|e| e.to_s+t(:klass_year)}.zip((2009..2020).to_a )
		
		@class_month = params[:menu_month] || DateTime.current.month
		@class_day   = params[:menu_day]   || DateTime.current.day
		@class_year  = params[:menu_year]  || DateTime.current.year
		@class_date  = Time.zone.parse("#{@class_year}-#{@class_month}-#{@class_day}")
		
		#@klasses = Klass.find_all_by_date( @class_date, :select=>'klasses.id, klasses.start_time, klasses.end_time, klasses.capacity, courses.name AS course__name, courses.id AS course__id', :joins=>:course)
		@klasses = Klass.find_all_by_date( @class_date, :include => [:course,:teachings,:teachers] )
		
		if can?( :manage, Klass ) && @klasses.size == 0
			TemplateClass.find_all_by_day( @class_date.strftime("%a").downcase ).each do |t|
    		t.create_class @class_date
			end
			@klasses = Klass.find_all_by_date( @class_date, :include => [:course,:teachings,:teachers] )
		end
    
    #@class_groups = @klasses.group_by{|e| e.course__name.split[0] }
    @class_groups = @klasses.group_by{|e| e.course.category }
    
    @teachers = User.with_role( "teacher" ).all( :include => :teacher_courses )
  end

#  
#  def add_student
#    StudentClass.new( :klass_id=>params[:klass_id], :cancel=>false ).save
#    redirect_to :action=>'index', :year=>params[:year], :month=>params[:month], :day=>params[:day]
#  end
#
#  def add_course
#    Klass.new(
#      :course_id=>params[:course_id],
#      :date=>DateTime.new(
#               params[:year].to_i,
#               Date::MONTHNAMES.index( params[:month] ),
#               params[:day].to_i ),
#      :start_time=>Time.parse( params[:start_time ]),
#      :end_time=>Time.parse( params[:end_time ]),
#			:cancel=>false
#    ).save
#    redirect_to :action=>'index',
#      :year=>params[:year],
#      :month=>params[:month],
#      :day=>params[:day]
#  end
#  
#  def schema
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @klasses }
#    end  
#  end
#
#  # GET /klasses/1
#  # GET /klasses/1.xml
#  def show
#  	@klass = Klass.find( params[:id], :include=>:course )
#  	@klass.revert_to( params[:version].to_i ) if params[:version]
#  	
#  	if !logged_in?
#  		login_redirection
#  		return
#  	elsif clearance == 4
#			registered_courses = current_user_status.courses.map(&:name)
#		  klasses = Klass.all(
#		    :conditions=>["courses.name in (?) and date >= ?", registered_courses, Date.current ],
#		    :include=>'course' )	    	
#  		unless current_user_status.klasses.include?( @klass ) || klasses.include?( @klass )  			
#  			flash[:error] = t('people.error.unauthorized_access')
#  			redirect_to default_page
#  			return
#  		end
#  	end
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @klass }
#    end
#  end
#
#  # GET /klasses/new
#  # GET /klasses/new.xml
#  def new
#    @klass = Klass.new()
#		@klass_date = params[ :klass_date ]
#		@teachers = []
#		
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @klass }
#    end
#  end
#
#  # GET /klasses/1/edit
#  def edit
#  	@klass = Klass.find( params[:id],
#  		:include=>[
#  			{ :students=>:person },
#  			:teacher,
#  			:course,
#  			:classroom ])
#		@teachers = Teacher.all(
#			:conditions=>["courses.name = ?", Course.find( @klass.course_id ).name],
#		  :include=>[:person, :courses])      			
#  end
#
#  # POST /klasses
#  # POST /klasses.xml
#  def create
#    @klass = Klass.new( params[ :klass ])
#    @klass_date = @klass.date.to_s
#		@teachers = []
#		if !params[:klass][:course_id].blank?
#			@teachers = Teacher.all(
#				:conditions=>["courses.name = ?", Course.find( params[:klass][:course_id] ).name],
#			  :include=>[:person, :courses])    
#		end
#    respond_to do |format|
#      if @klass.save
#        flash[:notice] = 'Klass was successfully created.'
#        format.html { redirect_to klasses_path( :date => @klass.date ) }
#        format.xml  { render :xml => @klass, :status => :created, :location => @klass }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @klass.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /klasses/1
#  # PUT /klasses/1.xml
#  def update
#   	@klass = Klass.find( params[:id],
#  		:include=>[
#  			{ :students=>:person },
#  			:teacher,
#  			:course,
#  			:classroom ])
#		course_id = @klass.course_id
#		  
#    if !logged_in?
#			login_redirection
#			return
#		elsif clearance >= 3 && !current_user.teacher.nil? && params[:klass][:note]
#			@klass.update_attribute( :note, params[:klass][:note] )
#			redirect_to @klass
#			flash[:notice] = "Note successfully updated."
#			return
#		elsif clearance >= 3
#			redirect_to current_user.student.nil? ? current_user.teacher : edit_klasses_student_path( current_user.student.id )
#			flash[:error] = "Illegal operation."
#			return
#		end
#  	  
#    respond_to do |format|
#      if @klass.update_attributes( params[:klass] )
#	      format.html{
#	      	if params[:redirect] == "courses"
#	      		redirect_to edit_course_path( @klass.course_id )
#					else
#						redirect_to klasses_path( :date => @klass.date )
#					end
#	        }
#        format.xml  { head :ok }
#      else
#        format.html{
#        	@klass.update_attribute( :course_id, course_id )
#        	@teachers = Teacher.all(
#						:conditions=>["courses.name = ?", Course.find( course_id ).name],
#					  :include=>[:person, :courses])    
#					render :action => "edit"
#        }
#        format.xml  { render :xml => @klass.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /klasses/1
#  # DELETE /klasses/1.xml

#
##  def authorize
##    unless session[:user_name]
##      session[:original_uri] = request.request_uri
##      flash[:notice] = "Please log in"
##      redirect_to :controller=>:admin, :action=>:login
##    end
##  end

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
	
	def load_courses
		@class_course = params[:class_course]
		if @class_course.blank?
	  	@courses = sort_courses.map{|e| ["#{e.name} (#{e.capacity})",e.id]}
		else
			@courses = Course.all( :conditions => ["name like (?)",@class_course+"%"], :order=>:name ).map{|e| ["#{e.name} (#{e.capacity})",e.id]}
		end
	end	
end
