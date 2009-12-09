class CommentsController < ApplicationController
	filter_resource_access

  def create
  	if !@comment.save
      flash[:error] = t('comments.error.blank')
    end
    redirect_to Event.find( @comment.event_id )
  end   
end
