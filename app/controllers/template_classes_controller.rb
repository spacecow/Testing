class TemplateClassesController < ApplicationController
  before_filter :load_classes_and_times
  
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
    @template_day = params[ :template_day ] || Date.current.strftime( "%A" )
    @template_klasses = TemplateClass.find_all_by_day( @template_day, :include => [ :course, :course_time, :classroom, { :teacher=>:person }])
    @template_groups = @template_klasses.group_by{|e| e.course.category }

		@classrooms = Classroom.all
		@teachers = Teacher.find( :all, :include => :person )
		@collision = {}
  end

  # GET /template_classes/1
  # GET /template_classes/1.xml
  def show
    @template_klass = TemplateClass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @template_klass }
    end
  end

  # GET /template_classes/new
  # GET /template_classes/new.xml
  def new
    @template_class = TemplateClass.new()
    #@course = params[ :course ]
    #@time = params[ :time ]
    #@template_day = params[ :template_day ]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @template_class }
    end
  end

  # GET /template_classes/1/edit
  def edit
    @template_class = TemplateClass.find(params[:id])
  end

  # POST /template_classes
  # POST /template_classes.xml
  def create
    @template_class = TemplateClass.new( params[ :template_class ])

    respond_to do |format|
      if @template_class.save
        flash[:notice] = 'TemplateClass was successfully created.'
        format.html { redirect_to( template_classes_path( :template_day=>@template_class.day )) }
        format.xml  { render :xml => @template_class, :status => :created, :location => @template_class }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @template_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /template_classes/1
  # PUT /template_classes/1.xml
  def update
    @template_class = TemplateClass.find(params[:id])

    respond_to do |format|
      if @template_class.update_attributes(params[:template_class])          

        format.html { redirect_to( template_classes_path( :template_day=>@template_class.day )) }
        #format.html { redirect_to template_classes_path }
        #format.html { redirect_to( @template_class, :template_day=>@template_class.day ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @template_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /template_classes/1
  # DELETE /template_classes/1.xml
  def destroy
    @template_class = TemplateClass.find(params[:id])
    @template_day = @template_class.day
    @template_class.destroy

    respond_to do |format|
      format.html { redirect_to :back } #(template_classes_path( :template_day=>@template_class.day )) }
      format.xml  { head :ok }
    end
  end

  def no_of_ten_minutes
    10
  end

private
  def load_classes_and_times
    @courses = Course.all
    @times = CourseTime.find( :all, :order=>'text' )
    @days = [['Choose a day'], ['Monday'], ['Tuesday'], ['Wednesday'], ['Thursday'], ['Friday'], ['Saturday'], ['Sunday']]
  end
  
  def find_schedule
    session[ :schedule ] ||= Schedule.new
  end
end

