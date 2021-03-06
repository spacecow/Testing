class AdminController < ApplicationController
  layout "login"
  
  def login
    #render :layout => "login"
    session[:user_name] = nil
    if request.post?
      user = Person.authenticate( params[:user_name], params[:password] )
      if user
      	set_username( user.user_name )
        uri = session[:original_uri]
        session[:original_uri] = nil
        if clearance >= 4
          redirect_to ( user.student.nil? ? user.teacher : edit_klasses_student_path( user.student.id ))
        else
          redirect_to( uri || klasses_path )
        end
      else
        flash.now[:error] = t 'login.flash.invalid_user_or_password'
      end
  	end
  end

  def logout
    reset_session
    flash[:notice] = t('logout.notice')
    redirect_to :action=>'login'
  end

  def index
  end

end
