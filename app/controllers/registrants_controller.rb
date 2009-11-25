class RegistrantsController < ApplicationController
	filter_resource_access
  
	def index
    #@registrants = Registrant.all
    @events = Event.all
  end
  
  def show
  end
  
  def new
  	if( user = current_user2 )
	    @registrant = Registrant.new(
	    	#:name => user.name,
	    	#:name_hurigana => user.name_hurigana,
	    	#:male => user.gender,
	    	#:tel => user.mobile_phone,
	    	:email => user.email
	    )
  	end
    @event = Event.find( params[:event_id] )
  end
  
  def create
    if @registrant.save
      flash[:notice] = "Successfully registered."
      redirect_to registrants_url
    else
    	@event = Event.find( params[:registrant][:event_id] )
      render :action => 'new'
    end
  end
  
  def edit
    @event = Event.find( @registrant.event_id )
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
  
  def authorize
  end  
  def authorize_view
	end    
end
