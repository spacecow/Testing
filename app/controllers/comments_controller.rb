class CommentsController < ApplicationController
	before_filter :authorize, :except=>[:create]

  def create
		@comment = Comment.create!( params[:comment] )
  	flash[:notice] = "Successfully added comment."
	  respond_to do |format|
	  	format.html{ redirect_to Event.find( @comment.event_id ) }
	  	format.js
	  end
  end	
end
