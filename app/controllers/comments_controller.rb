class CommentsController < ApplicationController
	filter_resource_access

	def new
		redirect_to Comment.new( params[:comment] ), :method => :post
	end

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
  	@setting = Setting.find_by_name( "main" )
  	params[:comment][:comment] = params[:comment][:comment].gsub("\r\n", "<br />");
  	if @comment.update_attributes( params[:comment] )
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
end
