class UserSessionsController < ApplicationController
  load_and_authorize_resource
  
  def new
    redirect_to mypage_path( current_user.username ) if current_user
    @user_session = UserSession.new( :username => params[:username] )
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      Rails.cache.delete( 'beta_testers' )
      #flash[:notice] = t( 'login.notice.success' )
      #redirect_to session[:original_uri] and return unless session[:original_uri].blank?
      redirect_to mypage_path( @user_session.username )
    else
      render :action => :new
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = t( 'logout.notice.success' )
    session[:original_uri] = ""
    redirect_to login_user_path
  end
end
