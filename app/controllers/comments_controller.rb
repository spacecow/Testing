class CommentsController < ApplicationController
	filter_resource_access

  def create
#  	@comment = Comment.new(params[:comment] )
  	@comment.save
    flash[:notice] = "Successfully created comment."
    redirect_to Event.find( @comment.event_id )
  end
  
  def authorize
  end  
  def authorize_view
	end   
end
