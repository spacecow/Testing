class StudentsController < ApplicationController
  skip_before_filter :authorize
  
  def index
    redirect_to :controller=>'people', :category=>"受講生"
  end
  
  def edit_courses
    @student = Student.find( params[:id], :include=>'courses' )
  end
  
  def update_courses
    params[:student][:course_ids] ||= []
    @student = Student.find( params[:id] )
    @student.update_attributes(params[:student])
    respond_to do |format|
      format.html { redirect_to :action=>"edit_klasses", :id=>@student }
    end
  end
  
  def edit_klasses
    @student = Student.find( params[:id], :include=>'klasses' )
		registered_classes = @student.courses.map(&:name)
	  @klass_groups = Klass.all(
	    :conditions=>["course_id = courses.id and courses.name in (?)", registered_classes ],
	    :include=>'course' ).group_by{|e| e.date.strftime("%x")}        
  end
  
  def update_classes
    params[:student][:klass_ids] ||= []
    @student = Student.find( params[:id] )
    @student.update_attributes(params[:student])
    respond_to do |format|
      format.html { redirect_to(@student) }
    end
  end
  
  def show
    @student = Student.find( params[:id] )
	  @attendance_groups = @student.attendances.reject{|e| e.klass.date < Date.current }.group_by{|e| e.klass.date.strftime("%x")}
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
end
