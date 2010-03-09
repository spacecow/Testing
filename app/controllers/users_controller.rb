class UsersController < ApplicationController
	before_filter :find_multiple_users, :only => [:edit_multiple, :update_multiple]
  load_and_authorize_resource

	def show
		@user = User.find( params[:id] )
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
	    	Mail.create!(
	      	:sender_id => User.find_by_name("Johan Sveholm").id,
	      	:recipient_id => @user.id,
	      	:subject => "registered#user",
	      	:message => "users.registered#Mafumafu"
	      )       	
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
  end
  
  def update
  	@user = User.find( params[:id] )
  	params[:user].delete(:occupation) if params[:user][:occupation].blank?
    if @user.update_attributes(params[:user])
      if( params[:user][:avatar].blank? )
      	if !params[:user][:klass_ids].blank?
      		flash[:notice] = t('notice.reserve_success',:object=>t(:klass_es).downcase)
			  	#mail = Mail.create!(
			    #	:sender_id => User.first.id,
			    #	:subject => "Reservation",
			    #	:message => "You have reserved a class!"
			    #)
			    #Recipient.create!( :mail_id=>mail.id, :user_id=>@user.id )
      	elsif !params[:user][:student_course_ids].blank? || !params[:user][:teacher_course_ids].blank?
      		flash[:notice] = t('notice.update_success',:object=>t('courses.title').downcase)
    		else
      		flash[:notice] = t('notice.update_success',:object=>t(:user).downcase)
      	end
      	if !params[:user][:student_course_ids].blank? || !params[:user][:teacher_course_ids].blank?
      		redirect_to users_path	
      	else
      		redirect_to mypage_path
      	end
    	else
    		render :action => "crop"
  		end
    else
      render :action => 'edit'
    end
  end

  def destroy
  	@user = User.find( params[:id] )
    @user.destroy
    flash[:notice] = "Successfully deleted user."
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
	
	def reserve
		todays_date = ( params[:majballe].nil? ? Date.current : Date.parse( params[:majballe] ))
		start_date = todays_date + 6.day
		start_date += 1.day while start_date.strftime("%a") != "Mon"
		@klasses = {}
		Klass.all(
			:conditions=>["date >= ? and date < ?", start_date, start_date+6.day],
			:include=>:course ).
				reject{|e| !@user.student_courses.include?( e.course )}.
				map{|e| @klasses[e.name] = @user.klasses.include?(@klasses[e.name]) ? @klasses[e.name] : (@user.klasses.include?(e) ? e : ( @klasses[e.name].nil? ? e : [@klasses[e.name],e][rand(2)])) }
		@reservable_klasses = []
		if %w( Sat Sun Mon Tue ).include?( todays_date.strftime("%a") )
			@reservable_klasses = @klasses.values.reject{|e| @user.klasses.include?(e)}.sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
		end	
		@reserved_klasses = @klasses.values.reject{|e| !@user.klasses.include?(e)}.sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
		@class_history = @user.klasses.reject{|e| e.date >= Date.current }
	end
	
	def edit_courses
		@status = params[:status]
		@courses = sort_courses
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
	
private

  def find_multiple_users
    @users = User.find( params[:user_ids] )
  end

	def sort_courses
  	@courses = []
  	@sorting = Sorting.new
  	@courses_groups = Course.all( :order=>:name ).group_by(&:category)
		@sorting.sort_in_mogi_order( @courses_groups.keys ).each do |key|
			@courses_groups[key].map{|course| @courses.push course }
		end
		@courses		
	end
end




























