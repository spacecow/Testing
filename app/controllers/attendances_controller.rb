class AttendancesController < ApplicationController
  def edit
    @attendance = Attendance.find(params[:id])
  end
 
  def update
    @attendance = Attendance.find(params[:id], :include=>:klass )
    
    option = params[:attendance][:student_id]
    if option == "line"
      redirect_to( klasses_path( :date => params[:date] ))
      return
    elsif option.starts_with?( 'Move to' )
      params[:klass_relations].split(',').each do |klass_relation|
        (key, k_id) = klass_relation.split('->')
        if( key == option.split[2] )
          params[:attendance][:klass_id] = k_id
          params[:attendance][:student_id] = @attendance.student_id
        end
      end
      if @attendance.update_attributes( params[:attendance] )
        redirect_to( klasses_path( :date => @attendance.klass.date ))
      else
        session[:error] = "You cannot change student yet."
        redirect_to( klasses_path )
      end
      return
	  elsif option == "Cancel"
      @attendance.update_attribute( :cancel, 1 ) if @attendance.chosen == true
	  	redirect_to( klasses_path( :date => params[:date] ))
      return
	  elsif option == "Delete"
	  	@attendance.destroy if @attendance.chosen == true
      redirect_to( klasses_path( :date => params[:date] ))
      return
	  else
      params[:attendance][:chosen] = 1
    end
    
    new_student_id = params[:attendance][:student_id]
    if new_student_id == ""
      params[:attendance][:chosen] = 0
    elsif busy_student?( new_student_id, @attendance.klass.date, @attendance.klass.start_time, @attendance.klass.end_time )
    	redirect_to( klasses_path( :date => @attendance.klass.date ))
    	flash[:error] = Student.find( new_student_id ).name+" is not available for this class"
    	return
    else
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
  
  def busy_student?( student_id, date, start_time, end_time )
  	Klass.find_all_by_date( date,
  		:conditions =>[
  			"(( start_time <= ? and end_time >= ? ) or ( start_time <= ? and end_time >= ? )) and attendances.chosen = ? and attendances.cancel = ? and students.id = ?",
  			start_time, start_time, end_time, end_time, true, false, student_id
  		],
  		:include => :students
  	).size > 0
  end
end