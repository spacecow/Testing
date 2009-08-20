class TeachersController < ApplicationController
	before_filter :authorize, :except=>[:show,:index]
	before_filter :authorize_view, :only=>[:index,:show]

  def index
  	flash[:notice] = flash[:notice] if flash[:notice]
  	flash[:error] = flash[:error] if flash[:error]
    redirect_to people_path( :category=>t('teachers.title'))
  end

  def show
	  if clearance == 3
	  elsif unauthorized_regular_user params[:id].to_i
  		redirect_to default_page
 			flash[:error] = t('people.error.unauthorized_access')
  		return
  	end
    @teacher = Teacher.find( params[:id], :include=>[ :person, { :klasses=>:course }, :courses ])
    @courses = @teacher.courses.group_by( &:category )
  	@sorting = Sorting.new
  	@keys = @sorting.sort_in_mogi_order( @courses.keys )
    @klass_groups = @teacher.klasses.reject{|e| e.date < Date.current }.group_by{|e| e.date.strftime("%x")}
    @history_groups = @teacher.klasses.reject{|e| e.date >= Date.current }.group_by{|e| e.date.strftime("%x")}
  end

  # GET /teachers/new
  # GET /teachers/new.xml
  def new
    @teacher = Teacher.new
    @person = Person.new( :ritei=>false, :inactive=>false )
    @person.teachers << @teacher

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @teacher }
    end
  end

  # GET /teachers/1/edit
  def edit
    @teacher = Teacher.find(params[:id])
  end

  def edit_multiple
    if params[:teacher_ids].nil?
  		flash[:error] = t('teachers.error.select')
  		redirect_to teachers_path
  		return
  	end
    @teachers = Teacher.find( params[:teacher_ids] )
  	@courses = Course.all.group_by( &:category )
  	@sorting = get_sorting
  	@keys = @sorting.sort_in_mogi_order( @courses.keys )
  end 

  def update_multiple
    params[:teacher][:course_ids] ||= []
    @teachers = Teacher.find( params[:teacher_ids] )
    @teachers.each do |teacher|
      if params[:no_courses].nil?
      	teacher.update_attributes!( params[:teacher].reject{ |k,v| v.blank? })
      else
      	teacher.update_attributes!( params[:teacher] )
      end
    end
    flash[:notice] = "Teachers updated"
    redirect_to teachers_path
  end

  # POST /teachers
  # POST /teachers.xml
  def create
    @teacher = Teacher.new(params[:teacher])

    respond_to do |format|
      if @teacher.save
        flash[:notice] = 'Teacher was successfully created.'
        format.html { redirect_to(@teacher) }
        format.xml  { render :xml => @teacher, :status => :created, :location => @teacher }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @teacher.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teachers/1
  # PUT /teachers/1.xml
  def update
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      if @teacher.update_attributes(params[:teacher])
        flash[:notice] = 'Teacher was successfully updated.'
        format.html { redirect_to(@teacher) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @teacher.errors, :status => :unprocessable_entity }
      end
    end
  end

	def edit_courses
  	@teacher = Teacher.find( params[:id], :include=>[ :person, :courses ])
  	@courses = Course.all.group_by( &:category )
  	@sorting = get_sorting
  	@keys = @sorting.sort_in_mogi_order( @courses.keys )
	end
	
	def update_courses
    params[:teacher][:course_ids] ||= []
    @teacher = Teacher.find( params[:id] )
    @teacher.update_attributes(params[:teacher])
    redirect_to @teacher
	end
  
private
  def authorize
    if !logged_in?
      session[:original_uri] = request.request_uri
      flash[:notice] = "Please log in"
      redirect_to :controller=>:admin, :action=>:login
    elsif clearance >= 3
      if params[:id].nil?
      	redirect_to default_page
      else
      	redirect_to default_page( Teacher.find( params[:id] ).person.id )
      end
      flash[:error] = t('people.error.unauthorized_access')
    end
  end  
  
  def authorize_view
	end

	def unauthorized_regular_user( id )
  	if clearance >= 4
  		if current_user.student.nil?
  			return current_user.teacher.id != id
  		else
  			return true
  		end
  	end
  	false
  end
end
