class CommentsController < ApplicationController
	filter_resource_access

  def create
  	@comment.save
    redirect_to Event.find( @comment.event_id )
  end   
end
