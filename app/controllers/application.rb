# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize, :except=>[:login,:logout,:index,:show,:live_search]
  before_filter :authorize_view, :only=>[:index,:show,:live_search]
  before_filter :set_user_language
  helper_method :clearance
  helper_method :clearance?
  helper_method :current_user
  helper_method :association_delete_error_messages

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
    if !logged_in?
      session[:original_uri] = request.request_uri
      flash[:notice] = t('login.title')
      redirect_to :controller=>:admin, :action=>:login
    elsif clearance >= 3
      redirect_to current_user.student.nil? ? current_user.teacher : edit_klasses_student_path( current_user.student.id )
    end
  end
  
  def authorize_view
    if !logged_in?
      session[:original_uri] = request.request_uri
      flash[:notice] = t('login.title')
      redirect_to :controller=>:admin, :action=>:login
    elsif clearance >= 4
      redirect_to current_user.student.nil? ? current_user.teacher : edit_klasses_student_path( current_user.student.id )
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
  
  def clearance
		if session[:user_name] == "johan_sveholm"
      return 1
    elsif session[:user_name] == "komatsu_aya"
      return 2
		elsif session[:user_name] == "thomas_osburg"
			return 3
		end
		return 4
  end

private
	def association_delete_error_message( association, mess )
		if !association.empty?
			return mess + ' (' + association.size.to_s + ')'
		end
	end
	
	def association_delete_error_messages( associations, messes )
		errors = []
		associations.each_with_index do |association,i|
			errors.push association_delete_error_message( associations[i], messes[i] )
		end
		errors.compact
	end	

  def current_user
    session[:user] ||= Person.find_by_user_name( session[:user_name], :include => 'student' )
  end  

  def default_page( person_id=-1 )
  	if clearance == 3
  		if person_id == -1
  			return klasses_path
  		end
  		person = Person.find( person_id, :include=>[ :student,:teacher ])
  		if( person.student.nil? )
  			person.teacher
  		else
  			person.student
  		end
  	else
	  	current_user.student.nil? ?
	  		current_user.teacher :
	  		edit_klasses_student_path( current_user.student.id )
	  end
	end

  def logged_in?
    session[:user_name] != nil
  end

  def set_user_language
    I18n.locale = logged_in? ? current_user.language : 'en'
  end  
  
  def get_sorting
		session[:sorting] ||= Sorting.new
	end
end
