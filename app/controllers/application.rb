# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize, :except=>[:login,:logout]
  before_filter :set_user_language
  helper_method :clearance?

  session :session_key => '_yoyaku_session_id'
  layout "courses"
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '251028ccdbfd8fbd09dbbdbe5de58b2c'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password

protected
  def authorize
    unless logged_in?
      session[:original_uri] = request.request_uri
      flash[:notice] = "Please log in"
      redirect_to :controller=>:admin, :action=>:login
    else
      unless clearance?(2)
        redirect_to :controller=>:klasses, :action=>"index"
      end
    end
  end
    
  def clearance?(level)
    if level>=1 && session[:user_name] == "johan_sveholm"
      return true
    elsif level>=2 && session[:user_name] == "komatsu_aya"
      return true
		elsif level>=3 && session[:user_name] == "thomas_osburg"
      return true
    elsif level>=4
      return true
    end
    return false
  end

private
  def current_user
    session[:user] ||= Person.find_by_user_name( session[:user_name], :include => 'student' )
  end  

  def logged_in?
    session[:user_name] != nil
  end

  def set_user_language
    I18n.locale = logged_in? ? current_user.language : 'jp'
    p I18n.locale
  end  
end
