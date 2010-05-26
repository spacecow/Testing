class MailerController < ApplicationController
	load_and_authorize_resource

  def index
		@months 		= t('date.month_names').compact.zip((1..12).to_a )
		@days   		=      (1..31).map{|e| e.to_s}.zip((1..31).to_a )
		@years  		= (2009..2020).map{|e| e.to_s}.zip((2009..2020).to_a )
		@languages 	= japanese? ? User::LANGUAGES_JA : User::LANGUAGES_EN
		@teachers		= User.with_role( :teacher ).map(&:name)
		@types			= SystemMailer::TYPES.map{|e| t(e)}.zip( SystemMailer::TYPES )
			
		@menu_month 		= params[:menu_month] 		|| DateTime.current.month
		@menu_day   		= params[:menu_day]   		|| DateTime.current.day
		@menu_year  		= params[:menu_year]  		|| DateTime.current.year
		@menu_date  		= Time.zone.parse("#{@menu_year}-#{@menu_month}-#{@menu_day}")
		@menu_language	= params[:menu_language]
		@menu_teacher		= params[:menu_teacher]
		@menu_type			= params[:menu_type]
		
		user = User.find_by_name( @menu_teacher )
		func = "get_#{@menu_type.split('_')[0..-3].join('_')}_teachings_to_at".to_sym
		teachings = SystemMailer.send( func, user, @menu_date.to_s )
		schedule = SystemMailer.get_schedule( teachings, user, @menu_language )
		summary = SystemMailer.get_summary( teachings, user, @menu_language )
		
		language = @menu_language == "ja" ? "japanese" : "english"
		@subject = case @menu_type
			when "daily_teacher_reminder"; @menu_language == "ja" ? "毎日思い起こさせるメール" : "Daily Reminder"
			when "weekly_teacher_schedule"; @menu_language == "ja" ? "一週間の講師スケジュール" : "Weekly Schedule"
			when "last_months_salary_teacher_summary"; @menu_language == "ja" ? "" : "Last Month's Salary Summary"
		end
		@mail = get_mail( "system_mailer/#{@menu_type}_in_#{language}.erb" )
		@mail.gsub!(/<%= @schedule %>/,schedule) unless schedule.nil?
		@mail.gsub!(/<%= @summary %>/,summary) unless summary.nil?
		@mail.gsub!(/<%= @day_6 %>/, (@menu_date.beginning_of_month+5.day).strftime("%a").downcase )
		@mail.gsub!(/<%= @last_month %>/,month_to_s(@menu_date-1.month, @menu_language))
		@mail.gsub!(/<%= @this_month %>/,month_to_s(@menu_date, @menu_language))
		@mail.gsub!(/<%= @name %>/,'')
		@mail.gsub!(/<%= @sender %>/,'Hitomi')
  end
  
  def send_mail
  	user = User.find_by_name( params[:menu_teacher] )
  	UserMailer.send_later( :deliver_mail, user, params[:subject], params[:body])
  	flash[:notice] = t('notice.mail_sent_to',:object=>user.email)
		redirect_to mailer_path(
			:menu_month => params[:menu_month],
			:menu_day => params[:menu_day],
			:menu_year => params[:menu_year],
			:menu_language => params[:menu_language],
			:menu_type => params[:menu_type],
			:menu_teacher => params[:menu_teacher]
		)
  end
end

def month_to_s( date, language )
	if language=="en"
		%w(~ January February March April May June July August September October November December)[date.month]
	elsif language=="ja"
		%w(~ 1月 2月 3月 4月 5月 6月 7月 8月 9月 10月 11月 12月)[date.month]
	end
end

def get_mail( path )
	mail = ""
	File.open "app/views/#{path}", 'r' do |f|
		f.readlines.each do |line|
			mail += line.chomp+"\r"
		end
	end
	mail
end
