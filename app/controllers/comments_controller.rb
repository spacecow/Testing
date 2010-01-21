class CommentsController < ApplicationController
	load_and_authorize_resource

	def new
		redirect_to Comment.new( params[:comment] ), :method => :post
	end

  def create
  	@comment.comment = @comment.comment.gsub("\n", "<br />");
  	if @comment.save    	
  	else
      flash[:error] = t('comments.error.blank')
    end
    redirect_to Event.find( @comment.event_id )
  end
  
  def edit
  	@event = Event.find( @comment.event, :include => [{:comments => :user}, {:gallery => :photos}, :registrants ] )
  end
  
  def update
  	@setting = Setting.find_by_name( "main" )
  	params[:comment][:comment] = params[:comment][:comment].gsub("\n", "<br />");
  	if @comment.update_attributes( params[:comment] )
  		send_mail( "updated", "comment", { :comments => true, :content => @comment.comment }) unless @comment.todo_id.blank?
  		if @comment.todo_id.blank?
  			redirect_to @comment.event
  		else
  			redirect_to @comment.todo
			end
		else
			@comment.comment = Comment.find( @comment ).comment
  		flash.now[:error] = t('error.blank',:object=>t(:comment))
  		if @comment.todo_id.blank?
  			@event = Event.find( @comment.event )
  			render :template => 'events/edit_comment'
  		else
  			@todo = Todo.find( @comment.todo )
  			render :template => 'todos/edit_comment'
			end		
			
			#redirect_to edit_comment_todo_path( @comment )
			
		end
  end
  
  def destroy
    @comment.destroy
    flash[:notice] = t('notice.delete_success', :object => t('comment').downcase )
  		if @comment.todo_id.blank?
  			redirect_to @comment.event
  		else
  			redirect_to @comment.todo
			end
		else
  end
  
  def send_mail( message, category, opts={} )
		@todo = Todo.find( @comment.todo_id )
  	opts = { :author => true }.merge!( opts )
  	mails = []
  	johan = User.find_by_name( "Johan Sveholm" )
  	@todo.comments.each{ |comment| mails.push comment.user } if opts[:comments]
  	@todo.votes.each{ |vote| mails.push vote.user } if opts[:votes]
  	mails.push @todo.user if opts[:author]
  	mails.push johan
  	mails.reject{|e| e==nil}.uniq.reject{|e| e==current_user }.each do |user|
    	Mail.create!(
      	:sender_id => current_user.id,
      	:recipient_id => user.id,
      	:subject => "#{message}##{category}",
	    	:message => "#{category.pluralize}.#{message}##{@todo.title}##{category=='todo'?'':'todo'}##{opts[:content]}"
      ) 
    end
  	Thread.new{ UserMailer.deliver_registration_confirmation( User.first ) }
  end	    
end
