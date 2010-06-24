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
  	send_mail "created"
		redirect_to :back
	end
  
	def edit
		@vote.update_attribute( :points, params[:points] )
		send_mail "changed"
		redirect_to :back
	end

  def destroy
  	@vote.destroy
  	send_mail "canceled"
  	redirect_to :back	
  end
  
  def send_mail( message )
  	god = User.with_role(:god).first
  	unless current_user == god
	  	mail = Mail.create!(
	    	:sender_id => current_user.id,
	    	:subject => "#{message}#vote",
	    	:message => "votes.#{message}##{@vote.todo.title}"
	    )
	    Recipient.create!( :mail_id=>mail.id, :user_id=>god.id )
    end
  end
end
