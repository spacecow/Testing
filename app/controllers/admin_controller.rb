class AdminController < ApplicationController
  layout "login"
  
  def login
    #render :layout => "login"
    session[:user_name] = nil
    if request.post?
      user = Person.authenticate( params[:user_name], params[:password] )
      if user
        session[:user_name] = user.user_name
        uri = session[:original_uri]
        session[:original_uri] = nil
        unless clearance?(3)
          redirect_to :controller=>'students', :action=>'edit_klasses', :id=>user.student.id
        else
          redirect_to( uri || klasses_path )
        end
      else
        flash.now[:notice] = "Invalid user"
      end
    end
  end

  def logout
    reset_session
    flash[:notice] = 'Successfully logged out'
    redirect_to :action=>'login'
  end

  def index
  end

end
