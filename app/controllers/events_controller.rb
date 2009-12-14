class EventsController < ApplicationController
	filter_resource_access
	
	def index
    @events = Event.all
    @setting = Setting.find_by_name( "main" )
  end
  
  def show
  	@event = Event.find( params[:id], :include => [{:comments => :user}, {:gallery => :photos}, :registrants ] )
    @comment = Comment.new
#    @user = current_user2
#    respond_to do |format|
#      format.html
#      format.css
#    end
  end
  
  def new
  end
  
  def create
    if @event.save
      @event.gallery = Gallery.create!
      flash[:notice] = "Successfully created event."
      redirect_to events_url
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @event.update_attributes(params[:event])
      flash[:notice] = "Successfully updated event."
      redirect_to @event
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @event.destroy
    flash[:notice] = "Successfully destroyed event."
    redirect_to events_url
  end

	  
  def authorize
  end  
  def authorize_view
	end    
end
