class UsersController < ApplicationController
	filter_resource_access

  def new
  end
  
  def create
    if @user.save
      flash[:notice] = t('users.notice.registration')
      redirect_to events_path
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
      flash[:notice] = "Successfully updated profile."
      redirect_to events_path
    else
      render :action => 'edit'
    end
  end
  
  def new_event_register
  	@user = current_user2
		@event = Event.find( params[:event_id] )
		@user.registrants.build( :event_id => @event.id )
	end
	
	def create_event_register
		@event = Event.find( params[:event_id] )
		if @user.update_attributes(params[:user])
      flash[:notice] = t('users.notice.successful_registration_for', :event => @event.title )
      redirect_to @event
    else
      render :action => 'new_event_register'
    end
	end
  
  def authorize
  end  
  def authorize_view
	end  
end
