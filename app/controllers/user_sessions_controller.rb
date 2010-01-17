class UserSessionsController < ApplicationController
	load_and_authorize_resource
  
	def new
  	redirect_to events_path if current_user
    @user_session = UserSession.new( :username => params[:username] )
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
    	#flash[:notice] = t( 'login.notice.success' )
      redirect_to events_path
    else
      render :action => :new
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = t( 'logout.notice.success' )
    redirect_to login_user_path
  end
end
