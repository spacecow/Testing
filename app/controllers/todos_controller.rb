class TodosController < ApplicationController
	filter_access_to :all

  def index
    @todos = Todo.all
  end
  
  def show
  	@todo = Todo.find( params[:id] )
  	@comment = Comment.new
  end
  
  def new
  	@todo = Todo.new(
  		:description => params[:description],
  		:user_id => ( params[:user_id].blank? ? current_user.id : params[:user_id] )
  	)
  	@comment_id = params[:comment_id]
  end
  
  def create
		#@todo.user_id = current_user.id
		params[:todo][:description] = params[:todo][:description].gsub("\r\n", "<br />");
		@todo = Todo.new( params[:todo] )
    if @todo.save
      flash[:notice] = t('notice.create_success', :object=>t(:todo))
      if( params[:comment_id].blank? )
      	redirect_to todos_path
      else
      	comment = Comment.find( params[:comment_id] )
      	event = Event.find( comment.event_id )
      	comment.destroy
      	redirect_to event
    	end
    else
      render :action => 'new'
    end
  end
  
  def edit
  	@todo = Todo.find( params[:id] )
  	@todo.description = @todo.description.gsub("<br />", "\r\n");
  end
  
  def update
  	params[:todo][:description] = params[:todo][:description].gsub("\r\n", "<br />");
  	@todo = Todo.find( params[:id] )
    if @todo.update_attributes(params[:todo])
      flash[:notice] = t('notice.update_success', :object=>t(:todo))
      redirect_to todos_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
  	@todo = Todo.find( params[:id] )
    @todo.destroy
    flash[:notice] = t('notice.delete_success', :object=>t(:todo))
    redirect_to todos_url
  end
  
  def add_comment
  	@comment = Comment.new( params[:comment] )
  	@comment.comment = @comment.comment.gsub("\r\n", "<br />");
  	if !@comment.save
      flash[:error] = t('error.blank',:object=>t(:comment))
    end
		respond_to do |wants|
			#wants.html { redirect_to Todo.find( @comment.todo_id ) }
			wants.js
		end
  end
  
  def edit_comment
  	@comment = Comment.find( params[:id] )
  	@todo = Todo.find( @comment.todo )
  	respond_to do |wants|
			wants.html
			wants.js
  	end	
  end
end