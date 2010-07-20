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
		language = @menu_language == "ja" ? "japanese" : "english"
		@mail = get_mail( "system_mailer/#{@menu_type}_in_#{language}.erb" )
		
		func = "get_#{@menu_type.split('_')[0..-3].join('_')}_teaching_info".to_sym
		@subject, @mail = send( func, user, @menu_date, @menu_language, @mail )

		#case @menu_type
		#when "last_months_salary_teacher_summary"; get_last_months_salary_teaching_info( user, @menu_date, @menu_language, @mail )
		#when "daily_teacher_reminder"; get_daily_teaching_info(  )
		#end
		
		#func = "get_#{@menu_type.split('_')[0..-3].join('_')}_teachings_to_at".to_sym
		
		
		#teachings 		= SystemMailer.send( func, user, @menu_date.to_s )
		#schedule 			= SystemMailer.get_schedule( teachings, user, @menu_language )

		
		#unless teachings.nil?
			#language = @menu_language == "ja" ? "japanese" : "english"
			#@subject = case @menu_type
			#	when "daily_teacher_reminder"; @menu_language == "ja" ? "毎日思い起こさせるメール" : "Daily Reminder"
			#	when "weekly_teacher_schedule"; @menu_language == "ja" ? "一週間の講師スケジュール" : "Weekly Schedule"
			#	when "last_months_salary_teacher_summary"; @menu_language == "ja" ? "来月の講師料金" : "Last Month's Salary Summary"
			#end
			#@mail.gsub!(/<%= @schedule %>/,schedule) unless schedule.nil?
			#@mail.gsub!(/<%= @summary %>/,summary) unless summary.nil?
			#@mail.gsub!(/<%= @teacher %>/,user.name)
			#@mail.gsub!(/<%= @yen_per_h %>/,user.cost.to_s)
			#@mail.gsub!(/<%= @hours %>/,hours.to_s)
			#@mail.gsub!(/<%= @teaching_cost %>/,teaching_cost.to_s)
			#if user.traveling_expenses.to_i > 0
			#	@mail.gsub!(/<%= @traveling_expenses %>/,"Traveling expenses: #{user.traveling_expenses}y×#{teaching_days.to_s}#{teaching_days==1 ? "day" : "days"}=#{total_traveling_expenses}y")
			#else
			#	@mail.gsub!(/<%= @traveling_expenses %>/,'')
			#end
			#if user.bank.empty?
			#	@mail.gsub!(/<%= @bank_name %>/,'')
			#	@mail.gsub!(/<%= @bank_branch %>/,'')
			#	@mail.gsub!(/<%= @bank_account %>/,'')
			#	@mail.gsub!(/<%= @bank_signup_name %>/,'')
			#else
			#	@mail.gsub!(/<%= @bank_name %>/,user.bank.first.name.to_s)
			#	@mail.gsub!(/<%= @bank_branch %>/,user.bank.first.branch.to_s)
			#	@mail.gsub!(/<%= @bank_account %>/,user.bank.first.account.to_s)
			#	@mail.gsub!(/<%= @bank_signup_name %>/,user.bank.first.signup_name.to_s)
			#end
			#@mail.gsub!(/<%= @teaching_days %>/,teaching_days.to_s)
			#@mail.gsub!(/<%= @total_traveling_expenses %>/,total_traveling_expenses.to_s)
			#@mail.gsub!(/<%= @total_cost %>/,total_cost.to_s)
			#@mail.gsub!(/<%= @confirm_day %>/, (@menu_date.beginning_of_month+5.day).strftime("%a").downcase )
			#@mail.gsub!(/<%= @last_month %>/,month_to_s(@menu_date-1.month, @menu_language))
			#@mail.gsub!(/<%= @this_month %>/,month_to_s(@menu_date, @menu_language))
			#@mail.gsub!(/<%= @name %>/,'')
			#@mail.gsub!(/<%= @sender %>/,'Hitomi')
		#end
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

def get_daily_teaching_info( user, date, language, mail )
	teachings 		= SystemMailer.get_daily_teachings_to_at( user, date.to_s )
	schedule 			= SystemMailer.get_schedule( teachings, user, language )	
	
	subject = ( language == "ja" ? "毎日思い起こさせるメール" : "Daily Reminder" )
	
	mail.gsub!(/<%= @sender %>/,'Hitomi' )
	mail.gsub!(/<%= @schedule %>/,schedule ) unless schedule.nil?
	[subject,mail]		
end

def get_weekly_teaching_info( user, date, language, mail )
	teachings 		= SystemMailer.get_weekly_teachings_to_at( user, date.to_s )
	schedule 			= SystemMailer.get_schedule( teachings, user, language )	
	
	subject = ( language == "ja" ? "一週間の講師スケジュール" : "Weekly Schedule" )
	
	mail.gsub!(/<%= @sender %>/,'Hitomi' )
	mail.gsub!(/<%= @schedule %>/,schedule ) unless schedule.nil?
	[subject,mail]		
end

def get_last_months_salary_teaching_info( user, date, language, mail )
	taught_or_untaught_teachings = SystemMailer.get_last_months_taught_or_untaught_salary_teachings_to_at( user, date.to_s )
	teachings     = taught_or_untaught_teachings.taught
	summary 			= SystemMailer.get_summary( teachings, user, language )
	hours 				= teachings.map(&:hours).sum
	teaching_cost	= teachings.map{|e| e.cost.to_i}.sum
	teaching_days = teachings.group_by(&:date).size
	total_traveling_expenses = teaching_days*user.traveling_expenses.to_i
	total_cost		= teaching_cost + total_traveling_expenses
	day_of_the_week = (date.beginning_of_month+5.day).strftime("%w").to_i
	
	subject = ( language == "ja" ? "来月の講師料金" : "Last Month's Salary Summary" )
	
	mail.gsub!(/<%= @last_month %>/,month_to_s( date-1.month,language ))
	mail.gsub!(/<%= @this_month %>/,month_to_s( date,language ))	
	mail.gsub!(/<%= @teacher %>/,user.name )
	mail.gsub!(/<%= @yen_per_h %>/,user.cost.to_s )
	mail.gsub!(/<%= @total_cost %>/,total_cost.to_s )
	mail.gsub!(/<%= @hours %>/,hours.to_s )	
	mail.gsub!(/<%= @teaching_cost %>/,teaching_cost.to_s )
	weekday = ""
	if user.traveling_expenses.to_i > 0
		if language=="en"
			mail.gsub!(/<%= @traveling_expenses %>/,"Traveling expenses: #{user.traveling_expenses}y×#{teaching_days.to_s}#{teaching_days==1 ? "day" : "days"}=#{total_traveling_expenses}y" )
			weekday = %w(sun mon tue wed thu fri sat)[day_of_the_week]
		elsif language=="ja"
			mail.gsub!(/<%= @traveling_expenses %>/,"Traveling expenses: #{user.traveling_expenses}円×#{teaching_days.to_s}日=#{total_traveling_expenses}円" )	
			weekday = %w(日 月 火 水 木 金 土)[day_of_the_week]
		end
	else
		mail.gsub!(/<%= @traveling_expenses %>/,'' )
	end
	mail.gsub!(/<%= @confirm_day %>/, weekday )
	if user.bank.empty?
		mail.gsub!(/<%= @bank_name %>/,'' )
		mail.gsub!(/<%= @bank_branch %>/,'' )
		mail.gsub!(/<%= @bank_account %>/,'' )
		mail.gsub!(/<%= @bank_signup_name %>/,'' )
	else
		mail.gsub!(/<%= @bank_name %>/,user.bank.first.name.to_s )
		mail.gsub!(/<%= @bank_branch %>/,user.bank.first.branch.to_s )
		mail.gsub!(/<%= @bank_account %>/,user.bank.first.account.to_s )
		mail.gsub!(/<%= @bank_signup_name %>/,user.bank.first.signup_name.to_s )
	end
	mail.gsub!(/<%= @summary %>/,summary) unless summary.nil?

	#start_date, end_date = SystemMailer.get_last_months_interval( @menu_date.to_s )
	#untaught_teachings = Teaching.between_dates( start_date, end_date ).current.confirmed.untaught.non_staff		
	flash[:error] = "#{user.name} has still unconfirmed classes." unless taught_or_untaught_teachings.untaught.empty?

	return [subject,mail]
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
