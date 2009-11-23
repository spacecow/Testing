class RegistrantsController < ApplicationController
  before_filter :authorize, :except=>[:new,:create,:index,:show]
  before_filter :authorize_view, :only=>[:show,:live_search]
  
	def index
    #@registrants = Registrant.all
    @events = Event.all
  end
  
  def show
    @registrant = Registrant.find(params[:id])
  end
  
  def new
  	user = current_user
    @registrant = Registrant.new(
    	:name => user.name,
    	:name_hurigana => user.name_hurigana,
    	:male => user.gender,
    	:tel => user.mobile_phone,
    	:email => user.mail_address_mobile
    )
    @event = Event.find( params[:event_id] )
  end
  
  def create
    @registrant = Registrant.new(params[:registrant])
    if @registrant.save
      flash[:notice] = "Successfully created registrant."
      redirect_to registrants_url
    else
    	@event = Event.find( params[:registrant][:event_id] )
      render :action => 'new'
    end
  end
  
  def edit
    @registrant = Registrant.find(params[:id])
    @event = Event.find( @registrant.event_id )
  end
  
  def update
    @registrant = Registrant.find(params[:id])
    if @registrant.update_attributes(params[:registrant])
      flash[:notice] = "Successfully updated registrant."
      redirect_to registrants_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @registrant = Registrant.find(params[:id])
    @registrant.destroy
    flash[:notice] = "Successfully destroyed registrant."
    redirect_to registrants_url
  end
end
