class StudentsController < ApplicationController
#  before_filter :authorize
  
  def index
    redirect_to :controller=>'people', :category=>"受講生"
  end
  
  def edit_courses
  	if clearance == 3
  		redirect_to Student.find( params[:id] )
  		flash[:error] = t('people.error.unauthorized_access')
  		return
  	elsif clearance >= 4
  		redirect_to default_page
  		flash[:error] = t('people.error.unauthorized_access')
  		return
  	end
  	@student = Student.find( params[:id], :include=>'courses' )
  	@sorting = Sorting.new
  	@course_groups = Course.all.group_by( &:category )
  	@keys = @sorting.sort_in_mogi_order( @course_groups.keys )
  end
  
  def update_courses
    params[:student][:course_ids] ||= []
    @student = Student.find( params[:id] )
    @student.update_attributes(params[:student])
    redirect_to edit_klasses_student_path( @student.id )
  end
  
  def edit_klasses
  	if clearance == 3
  		redirect_to Student.find( params[:id] )
  		return
  	elsif unauthorized_user params[:id].to_i
  		redirect_to default_page
  		flash[:error] = t('people.error.unauthorized_access')
  		return
  	end
    @student = Student.find( params[:id], :include=>'klasses' )
		registered_classes = @student.courses.map(&:name)
	  @klass_groups = Klass.all(
	    :conditions=>["courses.name in (?)", registered_classes ],
	    :include=>'course' ).group_by{|e| e.date.strftime("%x")}        
  end
  
  def update_klasses
    params[:student][:klass_ids] ||= []
    @student = Student.find( params[:id] )
    @student.update_attributes(params[:student])
    respond_to do |format|
      format.html { redirect_to(@student) }
    end
  end
  
  def show
  	if unauthorized_user params[:id].to_i
  		redirect_to default_page
  		flash[:error] = t('people.error.unauthorized_access')
  		return
  	end
    @student = Student.find( params[:id], :include => :klasses )
	  @attendance_groups = @student.attendances.reject{|e| e.klass.date < Date.current }.group_by{|e| e.klass.date.strftime("%x")}
	  @history_groups = @student.attendances.reject{|e| e.klass.date >= Date.current }.group_by{|e| e.klass.date.strftime("%x")}
  end
  
  def edit_multiple
    @students = Student.find( params[:student_ids] )
  end 
  
  def update_multiple
    params[:student][:course_ids] ||= []
    @students = Student.find( params[:student_ids] )
    @students.each do |student|
      student.update_attributes!( params[:student] )
    end
      flash[:notice] = "Updated students."
      redirect_to students_path
  end

private
  def authorize
    if !logged_in?
      session[:original_uri] = request.request_uri
      flash[:notice] = "Please log in"
      redirect_to :controller=>:admin, :action=>:login
    end
  end

	def unauthorized_user( id )
  	if clearance >= 4
  		if current_user.student.nil?
  			return true
  		else
  			return current_user.student.id != id
  		end
  	end
  	false
  end
end