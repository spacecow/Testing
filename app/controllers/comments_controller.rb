class CommentsController < ApplicationController
	filter_resource_access

  def create
  	@comment.comment = @comment.comment.gsub("\r\n", "<br />");
  	if !@comment.save
      flash[:error] = t('comments.error.blank')
    end
    redirect_to Event.find( @comment.event_id )
  end
  
  def edit
  	@event = Event.find( @comment.event, :include => [{:comments => :user}, {:gallery => :photos}, :registrants ] )
  end
  
  def update
  	params[:comment][:comment] = params[:comment][:comment].gsub("\r\n", "<br />");
  	p params[:comment][:comment]
  	if @comment.update_attributes( params[:comment] )
  		redirect_to Event.find( @comment.event )
		else
			@comment.comment = Comment.find( @comment ).comment
			@event = Event.find( @comment.event )
			flash[:error] = t('comments.error.blank')
			render :action => :edit
		end
  end
  
  def destroy
    @comment.destroy
    flash[:notice] = t('notice.delete_success', :object => t('comment').downcase )
    redirect_to @comment.event
  end
end
