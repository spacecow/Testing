class TodosController < ApplicationController
	filter_resource_access

  def index
    @todos = Todo.all
  end
  
  def show
  end
  
  def new
  	@todo.description = params[:description]
  	@todo.user_id = ( params[:user_id].blank? ? current_user.id : params[:user_id] )
  	@comment_id = params[:comment_id]
  end
  
  def create
		#@todo.user_id = current_user.id
    if @todo.save
      flash[:notice] = t(:create_success, :object => t(:todo))
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
  end
  
  def update
    if @todo.update_attributes(params[:todo])
      flash[:notice] = "Successfully updated todo."
      redirect_to @todo
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @todo.destroy
    flash[:notice] = "Successfully destroyed todo."
    redirect_to todos_url
  end
end