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
  helper_method :association_delete_error_message
	helper_method :units_per_schedule

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
	def login
	end

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
    
  def clearance?(level)
    if level>=1 && session[:user_name] == "johan_sveholm"
      return true
    elsif level>=2 && ( session[:user_name] == "daniel" || session[:user_name] == "komatsu_aya" || session[:user_name] == "aya" || session[:user_name] == "maki" || session[:user_name] == "umetsu" ||
    	session[:user_name] == "ikue" || session[:user_name] == "thomas" || session[:user_name] == "mogi" )
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
    elsif( session[:user_name] == "daniel" || session[:user_name] == "komatsu_aya" || session[:user_name] == "aya" || session[:user_name] == "maki" || session[:user_name] == "umetsu" ||
    	session[:user_name] == "ikue" || session[:user_name] == "thomas" || session[:user_name] == "mogi" )
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

  def current_user
		session[:user] ||= Person.find_by_user_name( session[:user_name], :include => [{ :student=>:klasses },{ :teacher=>:klasses }])
  end
  
  def current_user_status
		if current_user.teacher.nil?
			current_user.student
		else
			current_user.teacher
		end
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
	
	def generate_scheduled_units( schedule )
		scheduled_units = []
		template_hash = TemplateClass.all(
			:conditions=>["courses.name = ?", schedule.course.name],
			:include => :course
		).uniq_by( &:day_and_time_interval ).
			group_by( &:day )
			
		index = 0
		(0..90).to_a.map{|e| e.day.from_now }.each do |date|
			elements = template_hash[ date.strftime("%A") ]
			unless elements.nil?
				elements.sort_by( &:time_interval ).each do |e|
					break if( index += 1 ) > units_per_schedule
					
					scheduled_unit = schedule.equaled_scheduled_unit( date, e.start_time, e.end_time	)
					old_scheduled_unit = schedule.equaled_scheduled_unit( date - 7.days, e.start_time, e.end_time )
					unit_id = old_scheduled_unit ? ( old_scheduled_unit.unit_id ? old_scheduled_unit.unit_id+1 : nil ) : nil # = @classes[ equal_array.index( true ) ]
					if scheduled_unit.nil?
						scheduled_unit = ScheduledUnit.create!(
							:date => date,
							:start_time => e.start_time,
							:end_time => e.end_time,
							:unit_id => unit_id
						)
						schedule.scheduled_units << scheduled_unit
					else
						unless old_scheduled_unit.nil? || scheduled_unit.unit_id == unit_id
							scheduled_unit.update_attribute( :unit_id, unit_id ) 
						end
					end
					scheduled_units.push scheduled_unit 
				end
			end
		end
		scheduled_units
	end

  def logged_in?
    session[:user_name] != nil
  end

	def login_redirection
    session[:original_uri] = request.request_uri
    flash[:notice] = t('login.title')
    redirect_to :controller=>:admin, :action=>:login
	end

  def get_sorting
		session[:sorting] ||= Sorting.new
	end
	
	def get_settings
		session[:settings] ||= Setting.find_by_name( "main" )
	end

	def people_per_page
		get_settings.people_per_page
	end

	def set_settings( settings = 'main' )
		session[:settings] = Setting.find_by_name( "main" )
	end

	def set_username( username )
		session[:user_name] = username
	end        
		
  def set_user_language
    I18n.locale = logged_in? ? current_user.language : 'en'
  end  
	
	
	def units_per_schedule
		get_settings.units_per_schedule
	end
end
