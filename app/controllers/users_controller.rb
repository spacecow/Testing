class UsersController < ApplicationController
	before_filter :find_multiple_users, :only => [:edit_multiple, :update_multiple]
  load_and_authorize_resource

	def show
		@user = User.find( params[:id] )
	end

	def index
		@users = User.all
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
      	flash[:notice] = t('users.notice.edit_registration')
      	redirect_to mypage_path
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
		@klasses = {}
		Klass.all(
			:conditions=>["date >= ?", Date.current],
			:include=>:course ).
				reject{|e| !@user.courses.include?( e.course )}.
				map{|e| @klasses[e.name] = @user.klasses.include?(@klasses[e.name]) ? @klasses[e.name] : e }
		@reservable_klasses = @klasses.values.reject{|e| @user.klasses.include?(e)}.sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
		@reserved_klasses = @klasses.values.reject{|e| !@user.klasses.include?(e)}.sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}
		@class_history = @user.klasses.reject{|e| e.date >= Date.current }
	end
	
	def edit_courses
		@courses = sort_courses
	end

	def edit_multiple
		@courses = sort_courses
	end
	
	def update_multiple
		@users.each do |user|
			user.update_attributes!( params[:user].reject{|k,v| v.blank? } )
		end
		flash[:notice] = "yeah!"
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




























