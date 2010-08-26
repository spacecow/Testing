# -*- coding: utf-8 -*-
class UsersController < ApplicationController
	before_filter :find_multiple_users, :only => [:edit_multiple, :update_multiple]
  load_and_authorize_resource

  def show
    @user = User.find( params[:id] )
    if !params[:reserve].nil?; @page = "reserve"
    elsif !params[:already_reserved].nil?; @page = "already_reserved"
    elsif !params[:reserve_history].nil?; @page = "reserve_history"
    elsif !params[:confirm].nil?; @page = "confirm"
    elsif !params[:already_confirmed].nil?; @page = "already_confirmed"
    elsif !params[:confirm_history].nil?; @page = "confirm_history"
    end
#    params[:commit] = "Reserve" if params[:commit] == "Go!"
#    @page = %w(Reserve Confirm).include?( params[:commit]) ? params[:commit].downcase : nil

#    @page = params[:commit].blank? ? nil : params[:commit].downcase

    todays_date = Time.zone.now.beginning_of_day

    if can?( :edit_role, User ) && !Klass.first.nil?
      mon_date = Klass.last( :order => "date" ).date
      mon_date -= 1.day while mon_date.strftime("%a") != "Mon"
      sat_date = mon_date + 5.day
      reserve_date = sat_date - 14.day			
      week_intervals = [""]
      saturdays = [""]
      5.times do
        week_intervals << "#{mon_date.strftime('%m/%d')}～#{sat_date.strftime('%m/%d')}"
        saturdays << "#{reserve_date.strftime("%Y-%m-%d")}"
        mon_date -= 7.day
        sat_date -= 7.day
        reserve_date -= 7.day
      end
      @weeks = week_intervals.zip( saturdays )
    end
    
    unless Klass.first.nil?
      @saturday = params[:saturday]
      unless @saturday.blank?
        todays_date = Time.zone.parse( @saturday )
      end
    end

    start_date = todays_date + 6.day
    start_date += 1.day while start_date.strftime("%a") != "Mon"
    
    @klasses = {}
    Klass.all(
      :conditions=>["date >= ? and date < ?", start_date, start_date+6.day],
      :include=>:course ).
      reject{|e| !@user.student_courses.include?( e.course )}.each do |e|
      unless @user.student_klasses.include?( e.name )
        @klasses[e.name] ||= e
        @klasses[e.name] = [@klasses[e.name],e][rand(2)]
      end
      # @klasses[e.name] = @user.student_klasses.include?(@klasses[e.name]) ? @klasses[e.name] : (@user.student_klasses.include?(e) ? e : ( @klasses[e.name].nil? ? e : [@klasses[e.name],e][rand(2)]))
      end

    @reservable_klasses = []
    if %w( Sat Sun Mon Tue ).include?( todays_date.strftime("%a") )
      @reservable_klasses = @klasses.values.reject{|e| @user.student_klasses.include?(e)}.sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
    end	
    @reserved_attendances = @user.attendances.reject{|e| e.date < todays_date }.sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
    @attendance_history = @user.attendances.reject{|e| e.date >= todays_date }.sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}


    # Confirmatin for teachers
    sorted_klasses = @user.teacher_klasses.all.
      sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
    coming_klasses = sorted_klasses.
      reject{|e| e.teaching.nil? }.
      reject{|e| e.date < todays_date}
    
    @confirmable_classes = coming_klasses.
      reject{|e| e.teaching.status?( :confirmed )}.
      reject{|e| e.teaching.status?( :declined )}
    @confirmed_classes = coming_klasses.
      reject{|e| !e.teaching.status?( :confirmed )}
    @teaching_history = sorted_klasses.
      reject{|e| e.teaching.nil? }.
      reject{|e| e.date >= todays_date}.
      reject{|e| !e.teaching.nil? && !e.teaching.status?( :confirmed )}
    @declined_classes = sorted_klasses.
      reject{|e| !e.teaching.nil? && !e.teaching.status?( :declined )}
  end

	def index
		@status = params[:status] || "all"
		@users = @status=="all" ? User.all : User.with_role( @status )
	end

  def new
  	@user = User.new(
  		:nationality => ( japanese? ? "日本" : "" ),
  		:invitation_token => params[:invitation_token]
  	)
  	@user.email = @user.invitation.recipient_email if @user.invitation
  end
  
  def create
  	@user = User.new( params[:user] )
  	@user.invitation_limit = 0
    if @user.save
      if( params[:user][:avatar].blank? )
      	flash[:notice] = t('users.notice.new_registration')
	    	god = User.with_role(:god).first
	    	mail = Mail.create!(
	      	:sender_id => god.id,
	      	:subject => "registered#user",
	      	:message => "users.registered#Mafumafu"
	      )
	      Recipient.create!( :mail_id=>mail.id, :user_id=>god.id )
      	redirect_to events_path
    	else
    		render :action => "crop"
  		end
    else
      render :action => 'new'
    end
  end
  
  def edit
  	@user = User.find( params[:id] )
  	@user.bank.build if @user.bank.empty?
  end
  
  def update
		unless params[:user][:courses_teachers_attributes].nil?
	  	params[:user][:courses_teachers_attributes].each do |k,v|
				v.merge!( :_delete =>true ) if v[:chosen] == "0"
			end
		end
  	@user = User.find( params[:id] )
  	params[:user].delete(:occupation) if params[:user][:occupation].blank?
    
    if @user.update_attributes(params[:user])
      if( params[:user][:avatar].blank? )
      	if !params[:user][:student_course_ids].blank? || !params[:user][:courses_teachers_attributes].blank?
      		flash[:notice] = t('notice.update_success',:object=>t('courses.title').downcase )
    		else
      		flash[:notice] = t('notice.update_success',:object=>t(:user).downcase )
      	end
      	if !params[:user][:student_course_ids].blank? || !params[:user][:courses_teachers_attributes].blank?
      		redirect_to users_path( :status => "teacher" )
      	else
      		redirect_to mypage_path
      	end
    	else
    		render :action => "crop"
  		end
    else
    	if !params[:user][:courses_teachers_attributes].blank?
		  	params[:user][:courses_teachers_attributes].each do |k,v|
		  		@user.courses_teachers.select{|e| e.id == v[:id].to_i}.map{|e| e.chosen = false} if v[:chosen] == "0"
				end
				@status = params[:status]
				@courses = sort_courses @user.courses_teachers.map(&:course)
    		render :action => 'edit_courses'
      else
      	render :action => 'edit'
    	end
    end
  end

  def destroy
  	@user = User.find( params[:id] )
    @user.destroy
    flash[:notice] = t('notice.delete_success',:object=>t(:user).downcase )
    redirect_to users_url
  end
    
  def new_event_register
  	@user = current_user2
		@event = Event.find( params[:event_id] )
		#@user.registrants.build( :event_id => @event.id )
	end
	
	def create_event_register
		@user = current_user2
		@event = Event.find( params[:event_id] )
		if @user.update_attributes(params[:user])
      flash[:notice] = t('users.notice.successful_registration_for', :event => @event.title( japanese? ))
      redirect_to @event
    else
      render :action => 'new_event_register'
    end
	end
	
	def edit_role
		@user = User.find( params[:id] )
	end
	
	#:roles are not updated if :invitation_id is nil, why?
	def update_role
		@user = User.find( params[:id] )
		@user.update_attributes(params[:user])
		redirect_to users_path	
	end
	
	def change_password
		@token = params[:token]
		@reset_password = ResetPassword.find_by_token( @token )
		@user = @reset_password.user unless @reset_password.nil?
		if @user.nil?
			flash[:error] = t('error.no_pass_key')
			redirect_to root_path
		elsif @reset_password.used
			flash[:error] = t('error.used_pass_key')
			redirect_to root_path			
		end
	end
	
	def update_password
		@token = params[:token]
		@reset_password = ResetPassword.find_by_token( params[:token] )
		@user = @reset_password.user unless @reset_password.nil?
		if @user.nil?
			flash[:error] = t('error.pass_key')
			redirect_to root_path
		end
		if @user.update_attributes(params[:user])
    	flash[:notice] = t('notice.change_success', :object => t(:password).downcase )
    	@reset_password.update_attribute( :used, true )
    	#@reset_password.destroy
    	redirect_to root_path
    else
      render :action => 'change_password'
    end
	end
	
	def confirm
		todays_date = Time.zone.now
		unless params[:majballe].nil?
			todays_date = Time.zone.parse( params[:majballe] ) if can? User, :edit_role
		end

		sorted_klasses = @user.teacher_klasses.all.
			sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
		coming_klasses = sorted_klasses.
			reject{|e| e.teaching.nil? }.
			reject{|e| e.date < todays_date}

		@confirmable_classes = coming_klasses.
			reject{|e| e.teaching.status?( :confirmed )}.
			reject{|e| e.teaching.status?( :declined )}
		@confirmed_classes = coming_klasses.
			reject{|e| !e.teaching.status?( :confirmed )}
		@teaching_history = sorted_klasses.
			reject{|e| e.teaching.nil? }.
			reject{|e| e.date >= todays_date}.
			reject{|e| !e.teaching.nil? && !e.teaching.status?( :confirmed )}
		@declined_classes = sorted_klasses.
			reject{|e| !e.teaching.nil? && !e.teaching.status?( :declined )}
	end
	
	def update_confirm
		if @user.update_attributes(params[:user])
			flash[:notice] = t('notice.confirm_success',:object=>t(:klass_es).downcase)
		end
    redirect_to mypage_path and return if current_user.role? :teacher
    redirect_to users_path( :status => "teacher" )
	end
	
	def salary
		@months = t('date.month_names').compact.zip((1..12).to_a )
		@salary_month = params[:salary_month] || Time.zone.now.month
		
		@start_date = Time.zone.parse( "#{Date.current.year}-#{@salary_month}-01" )
		end_month = (@salary_month.to_i+1)%12
		end_year  = Time.zone.now.year+(@salary_month.to_i+1)/12
		@end_date = Time.zone.parse( "#{end_year}-#{end_month}-01" )
		@teachers = User.with_role( :teacher ).not_staff
	end
	
	def reserve	
		todays_date = Time.zone.now
		
		if can?( :edit_role, User ) && !Klass.first.nil?
			mon_date = Klass.last( :order => "date" ).date
			mon_date -= 1.day while mon_date.strftime("%a") != "Mon"
			sat_date = mon_date + 5.day
			reserve_date = sat_date - 14.day			
			week_intervals = [""]
			saturdays = [""]
			5.times do
				week_intervals << "#{mon_date.strftime('%m/%d')}～#{sat_date.strftime('%m/%d')}"
				saturdays << "#{reserve_date.strftime("%Y-%m-%d")}"
				mon_date -= 7.day
				sat_date -= 7.day
				reserve_date -= 7.day
			end
			@weeks = week_intervals.zip( saturdays )
		end

		unless Klass.first.nil?
			@saturday = params[:saturday]
			unless @saturday.nil?
				todays_date = Time.zone.parse( @saturday )
			end
		end

		start_date = todays_date + 6.day
		start_date += 1.day while start_date.strftime("%a") != "Mon"
		@klasses = {}
		Klass.all(
			:conditions=>["date >= ? and date < ?", start_date, start_date+6.day],
			:include=>:course ).
				reject{|e| !@user.student_courses.include?( e.course )}.
				map{|e| @klasses[e.name] = @user.student_klasses.include?(@klasses[e.name]) ? @klasses[e.name] : (@user.student_klasses.include?(e) ? e : ( @klasses[e.name].nil? ? e : [@klasses[e.name],e][rand(2)])) }
		@reservable_klasses = []
		if %w( Sat Sun Mon Tue ).include?( todays_date.strftime("%a") )
			@reservable_klasses = @klasses.values.reject{|e| @user.student_klasses.include?(e)}.sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
		end	
		@reserved_attendances = @user.attendances.reject{|e| e.date < todays_date }.sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
		@attendance_history = @user.attendances.reject{|e| e.date >= todays_date }.sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
	end
	
	def update_reserve
		p params
		student_klass_ids = params[:user].delete("student_klass_ids").reject{|e| e.blank?} || {}
    if !student_klass_ids.empty?
    	klass = nil
    	student_klass_ids.reverse.each do |klass_id|
  			klass = Klass.find( klass_id )
  			@user.student_klasses << klass
  		end
  		flash[:notice] = t('notice.reserve_success',:object=>t(:klass_es).downcase)
	  	SystemMailer.send_reservation_of_classes_by_ids( student_klass_ids, @user )
	  	#mail = Mail.create!(
	    #	:sender_id => User.first.id,
	    #	:subject => "Reservation",
	    #	:message => "You have reserved a class!"
	    #)
	    #Recipient.create!( :mail_id=>mail.id, :user_id=>@user.id )
	    redirect_to klasses_path( :menu_year=>klass.year, :menu_month=>klass.month, :menu_day=>klass.day ) and return
		end
    redirect_to mypage_path and return if current_user.role? :student
    redirect_to users_path( :status => "student" )
	end
	
	def edit_courses
		@user = User.find(params[:id], :include => :teacher_courses )
		@status = params[:status]
		@courses = sort_courses
		@courses.each do |course|
			@user.courses_teachers.build( :course_id => course.id, :cost => @user.cost ) unless @user.teacher_courses.include? course
		end
	end

	def edit_multiple
		@commit = params[:commit]
		@courses = sort_courses
	end
	
	def update_multiple
		@users.each do |user|
			user.update_attributes!( params[:user].reject{|k,v| v.blank? } )
		end
		if !params[:user][:student_course_ids].nil? || !params[:user][:teacher_course_ids].nil?
			flash[:notice] = t('notice.update_success',:object=>t('courses.title').downcase)
    elsif !params[:user][:roles].nil?			
    	flash[:notice] = t('notice.update_success',:object=>t('roles').downcase)
		end
		redirect_to users_path
	end

	def daily_teacher_reminder
		date = Date.current
		SystemMailer.daily_teacher_reminder_to_at( @user, "#{date.year}-#{date.month}-#{date.day}" )
		redirect_to users_path( :status => "teacher" ) and return
	end
	
	def weekly_teacher_schedule
		date = Date.current+1.day
		SystemMailer.weekly_teacher_schedule_to_from( @user, "#{date.year}-#{date.month}-#{date.day}" )
		redirect_to users_path( :status => "teacher" ) and return
	end


private

  def find_multiple_users
    @users = User.find( params[:user_ids] )
  end

	def sort_courses( courses=Course.all )
  	@courses = []
  	@sorting = Sorting.new
  	@courses_groups = courses.sort_by(&:name).group_by(&:category)
		@sorting.sort_in_mogi_order( @courses_groups.keys ).each do |key|
			@courses_groups[key].map{|course| @courses.push course }
		end
		@courses		
	end
end




























