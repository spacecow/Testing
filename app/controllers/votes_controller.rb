class VotesController < ApplicationController
  load_and_authorize_resource
  
  def index
  	@todos = Todo.all( :include => { :votes => :user })
  end
  
  def new
  	@vote.user_id = current_user.id
  	@vote.todo_id = params[:todo_id]
  	@vote.points = params[:points]
  	@vote.save
		redirect_to :back
	end
  
	def edit
		@vote.update_attribute( :points, params[:points] )
		redirect_to :back
	end

  def destroy
  	@vote.destroy
  	redirect_to :back	
  end
end
