class EventsController < ApplicationController
	filter_access_to :all
	
	def index
    @events = Event.all
    @setting = Setting.find_by_name( "main" )
  end
  
  def show
  	@event = Event.find( params[:id], :include => [{:comments => :user}, {:gallery => :photos}, :registrants ] )
    @comment = Comment.new
    @move_options = [["move","move"], ["todo","todo"]] + Todo.all.map{|e| [e.title, e.id]}
#    @user = current_user2
#    respond_to do |format|
#      format.html
#      format.css
#    end
  end
  
  def new
  	@event = Event.new
  end
  
  def create
  	@event = Event.new( params[:event] )
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
  	@event = Event.find( params[:id] )
    @event.destroy
    flash[:notice] = "Successfully destroyed event."
    redirect_to events_url
  end

  def add_comment
  	@comment = Comment.new( params[:comment] )
  	@comment.comment = @comment.comment.gsub("\r\n", "<br />");
  	if !@comment.save
      flash.now[:error] = t('error.blank',:object=>t(:comment))
    end
		respond_to do |wants|
			wants.html { redirect_to Event.find( @comment.event_id ) }
			wants.js
		end
  end
  
  def edit_comment
  	@comment = Comment.find( params[:id] )
  	@event = Event.find( @comment.event )
  	respond_to do |wants|
			wants.html
			wants.js
  	end	
  end  
  
  def move_comment
		if params[:move] == "todo"
			redirect_to new_todo_path(
				:description => params[:description].gsub("<br />", "\r\n"),
				:user_id => params[:user_id],
				:comment_id => params[:comment_id]
			)
			return
		elsif Todo.exists?( params[:move] )
			Comment.create!(
				:comment => params[:description].gsub("<br />", "\r\n"),
				:user_id => params[:user_id],
				:todo_id => params[:move]
			)
			Comment.find( params[:comment_id] ).delete
			redirect_to :back
		else
			redirect_to events_path	
		end
	end
end
