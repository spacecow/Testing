class KlassesController < ApplicationController  
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
			:tostring=>
			  Course.find( params[:course_id] ).name+"-"+
			  params[:start_time]+"-"+
			  params[:end_time],
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
	    p "----------"+@month.to_s+" "+@day.to_s+" "+@year.to_s
    else
    @month = params[:month] ? params[:month] : Date::MONTHNAMES[ Date.current.month ]
    @day = params[:day] ? params[:day] : Date.current.day
    @year = params[:year] ? params[:year] : Date.current.year
	    @klass_date = DateTime.new( @year.to_i,Date::MONTHNAMES.index( @month ),@day.to_i )
    end
    
    #@attendance = Attendance.find(params[:attendance]) if params[:attendance]
    
    @line = Attendance.find(1, :include => { :student => :person })
    @moves = Attendance.find( :all, :conditions=>[ "id in (?)", [2,3,4,5]], :include => { :student => :person })
    
    
    @klasses = Klass.find_all_by_date( @klass_date, :include=>[ :course, :classroom, :teacher, :attendances, { :students => :person }])
    @klass_groups = @klasses.group_by{|e| e.course.category }
    
    #_groups = Klass.find_all_by_date( @klass_date, :include=>['course','classroom',{ :teacher=>:person }, :students ]).group_by{|e| e.course.category 
    @classrooms = Classroom.all
    @teachers = Teacher.find( :all, :include=>'person' )
    
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
    @klass = Klass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @klass }
    end
  end

  # GET /klasses/new
  # GET /klasses/new.xml
  def new
    @klass = Klass.new( :cancel=>false )
		@klass_date = params[ :klass_date ]
		
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @klass }
    end
  end

  # GET /klasses/1/edit
  def edit
    @klass = Klass.find(params[:id])
    @courses = Course.all
    @teachers = Teacher.find :all,
      :conditions => ["person_id = people.id"],
      :include => :person
    @classrooms = Classroom.all

  end

  # POST /klasses
  # POST /klasses.xml
  def create
    @klass = Klass.new( params[ :klass ])
    @klass_date = @klass.date.to_s

    respond_to do |format|
      if @klass.save
        @klass.update_attribute( :tostring, @klass.course.name+"-"+@klass.start_time.to_s(:time)+"-"+@klass.end_time.to_s(:time))
        
        flash[:notice] = 'Klass was successfully created.'
        format.html { redirect_to( @klass ) }
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
    @klass = Klass.find(params[:id])

    respond_to do |format|
      if @klass.update_attributes(params[:klass])
      @klass.update_attribute( :tostring, @klass.course.name+"-"+@klass.start_time.to_s(:time)+"-"+@klass.end_time.to_s(:time) )
        format.html {
        	redirect_to(
        	  klasses_path(
        	    :year=>@klass.date.year,
        	    :month=>Date::MONTHNAMES[@klass.date.mon],
        	    :day=>@klass.date.day
        	  )
        	)
        }

        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @klass.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /klasses/1
  # DELETE /klasses/1.xml
  def destroy
    @klass = Klass.find(params[:id])
    if !@klass.attendances.empty?
      flash[:error] = t 'klasses.flash.try_to_delete_klass_with_students'
      redirect_to klasses_path( :date => params[:date] )
      return
    end
    @klass.destroy

    respond_to do |format|
      format.html { redirect_to klasses_path( :date => params[:date] )}
      format.xml  { head :ok }
    end
  end

protected
  def authorize
    unless session[:user_name]
      session[:original_uri] = request.request_uri
      flash[:notice] = "Please log in"
      redirect_to :controller=>:admin, :action=>:login
    end
  end
end
