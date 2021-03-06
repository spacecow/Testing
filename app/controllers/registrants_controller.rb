class RegistrantsController < ApplicationController
	load_and_authorize_resource
  
	def index
    #@registrants = Registrant.all
    @events = Event.find( :all, :include => { :registrants => :user })
  end
  
  def show
  end
  
  def new
  	@user = current_user
    @event = Event.find( params[:event_id] )
  end
  
  def create
    @event = Event.find( params[:registrant][:event_id] )
  	if @registrant.save
      flash[:notice] = t( 'registrants.notice.success', :event => @event.title )
      redirect_to @event
    else
      render :action => 'new'
    end
  end
  
  def edit
    @event = Event.first #find( @registrant.event_id )
  end
  
  def update
    if @registrant.update_attributes(params[:registrant])
      flash[:notice] = "Successfully updated registrant."
      redirect_to registrants_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @registrant.destroy
    flash[:notice] = "Successfully destroyed registrant."
    redirect_to registrants_url
  end
end
