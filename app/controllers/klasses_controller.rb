class KlassesController < ApplicationController  
  before_filter :authorize_view, :only=>[:index,:live_search]
  
  def add_student
    StudentClass.new( :klass_id=>params[:klass_id], :cancel=>false ).save
    redirect_to :action=>'index', :year=>params[:year], :month=>params[:month], :day=>params[:day]
  end

  def add_course
    Klass.new(
      :course_id=>params[:course_id],
      :date=>DateTime.new(
               params[:year].to_i,
               Date::MONTHNAMES.index( params[:month] ),
               params[:day].to_i ),
      :start_time=>Time.parse( params[:start_time ]),
      :end_time=>Time.parse( params[:end_time ]),
			:cancel=>false
    ).save
    redirect_to :action=>'index',
      :year=>params[:year],
      :month=>params[:month],
      :day=>params[:day]
  end

  # GET /klasses
  # GET /klasses.xml
  def index
    if params[:date]
	    @klass_date = DateTime.parse( params[:date] )
	    @month = Date::MONTHNAMES[ @klass_date.month ]
	    @day = @klass_date.day
	    @year = @klass_date.year
    else
	    @month = params[:month] ? params[:month] : Date::MONTHNAMES[ Date.current.month ]
	    @day = params[:day] ? params[:day] : Date.current.day
	    @year = params[:year] ? params[:year] : Date.current.year
		  @klass_date = DateTime.new( @year.to_i,Date::MONTHNAMES.index( @month ),@day.to_i )
    end
    
    #@attendance = Attendance.find(params[:attendance]) if params[:attendance]
    
    @line = [["----------","line"]]
    @moves = [["Move to 1","Move to 1"],["Move to 2","Move to 2"],["Move to 3","Move to 3"],["Move to 4","Move to 4"]]
    @options = [["Cancel","Cancel"],["Delete","Delete"]]
    
    @klasses = Klass.find_all_by_date( @klass_date, :include=>[ :course, :classroom, :teacher, :attendances, { :students => :person }])
    if clearance?(2)
			if @klasses.size == 0
	  		TemplateClass.find( :all, :conditions => [ "day = ?", @klass_date.strftime("%A") ]).each do |t|
	    		Klass.new(
						:course_id=>t.course_id,
						:teacher_id=>t.teacher_id,
						:classroom_id=>t.classroom_id,
						:capacity=>t.capacity,      
						:date=>@klass_date,
						:start_time=>t.start_time,
						:end_time=>t.end_time,
						:title=>t.title,
						:description=>t.description,
						:cancel=>t.inactive,
						:mail_sending=>t.mail_sending,
						:note=>t.note
		    	).save
	  		end
	  	end
	  	@klasses = Klass.find_all_by_date( @klass_date, :include=>[ :course, :classroom, { :teacher=> :person }, :attendances, { :students => :person }])
		end

    @klass_groups = @klasses.group_by{|e| e.course.category }
    
    #_groups = Klass.find_all_by_date( @klass_date, :include=>['course','classroom',{ :teacher=>:person }, :students ]).group_by{|e| e.course.category 
    @classrooms = Classroom.all
    @teachers = Teacher.find( :all, :include=>[:person,:courses] )
    
    @collition = {}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @klasses }
    end
  end
  
  def schema
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @klasses }
    end  
  end

  # GET /klasses/1
  # GET /klasses/1.xml
  def show
  	@klass = Klass.find( params[:id], :include=>:course )

		registered_courses = current_user_status.courses.map(&:name)
	  klasses = Klass.all(
	    :conditions=>["courses.name in (?) and date >= ?", registered_courses, Date.current ],
	    :include=>'course' )	  
  	
  	if !logged_in?
  		login_redirection	
  		return
  	elsif clearance == 4
  		unless current_user_status.klasses.include?( @klass ) || klasses.include?( @klass )  			
  			redirect_to default_page
  			return
  		end
  	end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @klass }
    end
  end

  # GET /klasses/new
  # GET /klasses/new.xml
  def new
    @klass = Klass.new()
		@klass_date = params[ :klass_date ]
		@teachers = []
		
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @klass }
    end
  end

  # GET /klasses/1/edit
  def edit
  	@klass = Klass.find( params[:id],
  		:include=>[
  			{ :students=>:person },
  			:teacher,
  			:course,
  			:classroom ])
		@teachers = Teacher.all(
			:conditions=>["courses.name = ?", Course.find( @klass.course_id ).name],
		  :include=>[:person, :courses])      			
  end

  # POST /klasses
  # POST /klasses.xml
  def create
    @klass = Klass.new( params[ :klass ])
    @klass_date = @klass.date.to_s
		@teachers = []
		if !params[:klass][:course_id].blank?
			@teachers = Teacher.all(
				:conditions=>["courses.name = ?", Course.find( params[:klass][:course_id] ).name],
			  :include=>[:person, :courses])    
		end
    respond_to do |format|
      if @klass.save
        flash[:notice] = 'Klass was successfully created.'
        format.html { redirect_to klasses_path( :date => @klass.date ) }
        format.xml  { render :xml => @klass, :status => :created, :location => @klass }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @klass.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /klasses/1
  # PUT /klasses/1.xml
  def update
  	@klass = Klass.find( params[:id],
  		:include=>[
  			{ :students=>:person },
  			:teacher,
  			:course,
  			:classroom ])
		course_id = @klass.course_id
			  
    respond_to do |format|
      if @klass.update_attributes( params[:klass] )
	      format.html{
	      	if params[:redirect] == "courses"
	      		redirect_to edit_course_path( @klass.course_id )
					else
						redirect_to klasses_path( :date => @klass.date )
					end
	        }
        format.xml  { head :ok }
      else
        format.html{
        	@klass.update_attribute( :course_id, course_id )
        	@teachers = Teacher.all(
						:conditions=>["courses.name = ?", Course.find( course_id ).name],
					  :include=>[:person, :courses])    
					render :action => "edit"
        }
        format.xml  { render :xml => @klass.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /klasses/1
  # DELETE /klasses/1.xml
  def destroy
    @klass = Klass.find( params[:id] )

		error = association_delete_error_message(
			@klass.attendances,
			t('klasses.error.try_to_delete_klass_with_students' ))
										
		if( !error.blank? )
      flash[:error] = error
      redirect_to :back #klasses_path( :date => params[:date] )
      return
    end
    
    @klass.destroy
    respond_to do |format|
      format.html { redirect_to :back } #klasses_path( :date => params[:date] )}
      format.xml  { head :ok }
    end
  end

#  def authorize
#    unless session[:user_name]
#      session[:original_uri] = request.request_uri
#      flash[:notice] = "Please log in"
#      redirect_to :controller=>:admin, :action=>:login
#    end
#  end
end
