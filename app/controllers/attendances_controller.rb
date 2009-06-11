class AttendancesController < ApplicationController
  def edit
    @attendance = Attendance.find(params[:id])
  end
 
  def update
    @attendance = Attendance.find(params[:id])
    new_student_id = params[:attendance][:student_id]
    
    if new_student_id == ""
      params[:attendance][:chosen] = 0
    else
      student = Student.find( new_student_id )
	    if student.name == "----------"
	      redirect_to( klasses_path( :date => params[:date] ))
	      return
	    elsif student.name.starts_with?( 'Move to' )
	      redirect_to( klasses_path( :date => params[:date] ))
	      return	      
	    end
      params[:attendance][:chosen] = 1
	    if( @attendance.student_id != new_student_id.to_i )
	      # must include time interval also
	      # @klasses = Klass.find_all_by_date( @attendance.klass.date,
	      #  :conditions=>["course_id = ?", @attendance.klass.course.id ])
	      # if it exists in @klasses,
	      # @klasses.students.include?( Student.find( params[:attendance][:student_id] ))
	      # Attendance.find(params[:id])
	      # { :attendance => @attendance.student_id }
	      params[:relations].split(',').each do |relation|
	        (a_id, s_id) = relation.split('->')
	        if( s_id == new_student_id )
	          Attendance.find( a_id ).update_attributes( :student_id => @attendance.student_id )
	        end
	      end
	    end
    end
    
    respond_to do |format|
      if @attendance.update_attributes(params[:attendance])
        format.html { redirect_to( klasses_path( :date => params[:date] )) }
        format.xml  { head :ok }
      else
        session[:error] = "You cannot change student yet."
        format.html { redirect_to( klasses_path ) }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end
end