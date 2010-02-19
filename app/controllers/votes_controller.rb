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
  	johan = User.find_by_name( "Johan Sveholm" )
  	unless current_user == johan
	  	mail = Mail.create!(
	    	:sender_id => current_user.id,
	    	#:recipient_id => johan.id,
	    	:subject => "#{message}#vote",
	    	:message => "votes.#{message}##{@vote.todo.title}"
	    )
	    Recipient.create!( :mail_id=>mail.id, :user_id=>johan.id )
    end
  end
end
