class UsersController < ApplicationController
	filter_resource_access

	def show
	end

	def index
		@users = User.all
	end

  def new
  	@user = User.new( :nationality => ( japanese? ? "日本" : "" ))
  end
  
  def create
    if @user.save
      if( params[:user][:avatar].blank? )
      	flash[:notice] = t('users.notice.new_registration')
      	redirect_to events_path
    	else
    		render :action => "crop"
  		end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_user2
  end
  
  def update
    @user = current_user2
    if @user.update_attributes(params[:user])
      if( params[:user][:avatar].blank? )
      	flash[:notice] = t('users.notice.edit_registration')
      	redirect_to events_path
    	else
    		render :action => "crop"
  		end
    else
      render :action => 'edit'
    end
  end

  def destroy
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
		@event = Event.find( params[:event_id] )
		if @user.update_attributes(params[:user])
      flash[:notice] = t('users.notice.successful_registration_for', :event => @event.title( japanese? ))
      redirect_to @event
    else
      render :action => 'new_event_register'
    end
	end 
end
