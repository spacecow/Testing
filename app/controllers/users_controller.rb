# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_filter :find_multiple_users, :only => [:edit_multiple, :update_multiple]
  before_filter :find_user_by_username, :only => :show
  load_and_authorize_resource

  def show
    redirect_to reserve_user_path(@user) and return if student?
    redirect_to confirm_user_path(@user) and return if teacher?
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
          redirect_to mypage_path(@user.username)
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

  def edit_time_secretly
  end
  
  def reserve
    todays_date = Time.zone.now.beginning_of_day
    if can?( :edit_time_secretly, User ) && Klass.count != 0
      mon = Klass.last_monday
      @weeks = week_range(mon, mon+5.day, mon-9.day, 5)
    end
    if can? :edit_time_secretly, User
      @saturday = params[:saturday]
      todays_date = Time.zone.parse(@saturday) unless @saturday.nil?
    end

    @message = t('message.no_reservations')
    @klasses = []
    if %w( Sat Sun Mon Tue ).include?( todays_date.strftime("%a"))
      start_date = monday_after_next(todays_date)
      temp_classes = Klass.between_dates( start_date, start_date+6.day )
      reject_not_enrolled_courses(temp_classes)
      reject_instances_of_already_reserved_classes(temp_classes)
      reject_already_reserved_classes(temp_classes) unless admin?
      temp_classes = reject_duplicates_and_randomize_instances(temp_classes)
      @klasses = sort_after_date_and_time_interval(temp_classes)
    else
      @message = t('message.time_for_reservation')
    end
  end

  def now( date, time )
    now = date.blank? ? Time.zone.now : Time.zone.parse(date)
    unless time.blank?
      time_instance = Time.zone.parse(time)
      now += time_instance.hour.hour + time_instance.min.minute
    end
    now
  end

  def edit_time() end

  def get_date( string, date, category )
    return string unless string.nil?
    return Time.zone.parse(date).send("strftime",category) unless date.nil?
    Time.zone.now.send("strftime",category)
  end
  def already_reserved
    @saturday = params[:saturday]
    @months = t('date.month_names').compact.zip((1..12).to_a )
    @days   =      (1..31).map{|e| e.to_s+t(:klass_day)}.zip((1..31).to_a )
    @years  = (2009..2020).map{|e| e.to_s+t(:klass_year)}.zip((2009..2020).to_a )
    @menu_month = get_date( params[:menu_month], @saturday, "%m" )
    @menu_day   = get_date( params[:menu_day], @saturday, "%d" )
    @menu_year  = get_date( params[:menu_year], @saturday, "%Y" )

    @saturday = @menu_year.to_s+"-"+@menu_month.to_s+"-"+@menu_day.to_s
    now = can?( :edit_time, User ) ? now(@saturday, params[:time]) : Time.zone.now
    temp_attendances = @user.attendances.reject{|e| e.start_date < now }
    @attendances = sort_after_date_and_time_interval(temp_attendances)
  end
  
  def update_reserve
    start_date = monday_after_next( Time.zone.parse( params[:saturday] ))
    klass_ids = @user.student_klasses.between_dates( start_date, start_date+6.day ).map(&:id) if admin?

    student_klass_ids = params[:user].delete("student_klass_ids").reject{|e| e.blank?} || {}
    if !student_klass_ids.empty?
      klass = nil
      student_klass_ids.reverse.each do |klass_id|
        klass = Klass.find( klass_id )
        unless @user.not_enrolled?( klass.course ) || @user.already_reserved_instance?( klass.to_s, klass.id )
          if @user.already_reserved?( klass )
            klass_ids.delete( klass.id ) if admin?
          else
            @user.student_klasses << klass
          end
        end
      end
      flash[:notice] = t('notice.reserve_success',:object=>t(:klass_es).downcase)
      SystemMailer.send_reservation_of_classes_by_ids( student_klass_ids, @user )
      #mail = Mail.create!(
      #	:sender_id => User.first.id,
      #	:subject => "Reservation",
      #	:message => "You have reserved a class!"
      #)
      #Recipient.create!( :mail_id=>mail.id, :user_id=>@user.id )
      #redirect_to klasses_path( :menu_year=>klass.year, :menu_month=>klass.month, :menu_day=>klass.day ) and return
    end
    klass_ids.each{|id| @user.student_klasses.delete( Klass.find(id) )} if admin?
    redirect_to already_reserved_user_path(@user) and return #if !staff?
    redirect_to users_path( :status => "student" )
  end


  def confirm
    now = Time.zone.now.beginning_of_day
    if can?( :edit_role, User ) && Klass.count != 0
      mon = Klass.last_monday
      @weeks = week_range(mon, mon+5.day, mon-9.day, 5)
      @saturday = params[:saturday]
      now = can?( :edit_time, User ) ? now(params[:saturday], params[:time]) : Time.zone.now
    end
    unsorted_klasses = @user.teacher_klasses.
      not_confirmed.
      not_declined.
      current
    unsorted_klasses.reject!{|e| e.start_date < now}
    @klasses = sort_after_date_and_time_interval( unsorted_klasses )
  end

  def already_confirmed
    now = can?( :edit_time, User ) ? now(params[:saturday], params[:time]) : Time.zone.now
    unsorted_klasses = @user.teacher_klasses.confirmed
    unsorted_klasses.reject!{|e| e.start_date < now}
    @klasses = sort_after_date_and_time_interval( unsorted_klasses )
  end
  
  def update_confirm
    now = params[:saturday].blank? ? Time.zone.now : Time.zone.parse( params[:saturday] )
    teachings_attributes = params[:user]["teachings_attributes"]
    teachings_attributes.each do |e|
      next if e[1]["confirm"].nil?
      teaching = Teaching.find(e[1]["id"])
      if teaching.status? :declined
        flash[:error] = "You cannot confirm an already declined class."
      elsif !teaching.current
        flash[:error] = "You cannot confirm a class you do not have."
      elsif teaching.klass.start_date < now
        flash[:error] = "You cannot confirm a class that already is over."
      else
        teaching.confirm = e[1]["confirm"]
      end
    end
    if flash[:error].blank?
      flash[:notice] = t('notice.confirm_success',:object=>t(:klass_es).downcase)
      redirect_to already_confirmed_user_path(@user)  #unless staff?
    else
      redirect_to confirm_user_path(@user)
    end
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

  def monday_after_next( todays_date )
    start_date = todays_date + 6.day
    start_date += 1.day while start_date.strftime("%a") != "Mon"
    start_date
  end

  def reject_not_enrolled_courses( array )
    array.reject!{|e| @user.not_enrolled?( e.course )}
  end

  def reject_already_reserved_classes( array )
    array.reject!{|e| @user.already_reserved?(e)}
  end

  def reject_instances_of_already_reserved_classes( array )
    klass_ids = @user.student_klasses.map(&:id)
    klass_group = array.group_by(&:to_s)
    klass_group.each do |key,value|
      klass = klass_group[key].select{|e| klass_ids.include?(e.id)}.first
      array.reject!{|e| e.to_s == klass.to_s && e != klass }
    end
  end

  def reject_duplicates_and_randomize_instances( array )
    klass_hash = {}
    array.each do |e|
      klass_hash[e.name] ||= e
      klass_hash[e.name] = [klass_hash[e.name],e][rand(2)]
    end
    klass_hash.values
  end

  def sort_after_date_and_time_interval( array )
    array.sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
  end
  
  def reserve2
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
  
  def find_user_by_username
    if params[:id].nil?
      @user = User.find_by_username( params[:username] )
    else
      @user = User.find( params[:id] )
    end
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




























