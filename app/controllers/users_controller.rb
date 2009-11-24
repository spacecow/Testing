class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to events_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_user2
  end
  
  def update
    @user = current_user2
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to events_path
    else
      render :action => 'edit'
    end
  end
  
  def authorize
  end  
  def authorize_view
	end  
end
