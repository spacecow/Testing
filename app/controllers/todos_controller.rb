class TodosController < ApplicationController
	filter_resource_access

  def index
    @todos = Todo.all
  end
  
  def show
  end
  
  def new
  end
  
  def create
		@todo.user_id = current_user.id
    if @todo.save
      flash[:notice] = t(:create_success, :object => t(:todo))
      redirect_to todos_url
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