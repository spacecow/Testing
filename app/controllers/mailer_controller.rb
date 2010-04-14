class MailerController < ApplicationController
  def index
		@months = t('date.month_names').compact.zip((1..12).to_a )
		@days   =      (1..31).map{|e| e.to_s}.zip((1..31).to_a )
		@years  = (2009..2020).map{|e| e.to_s}.zip((2009..2020).to_a )
		
		@menu_month = params[:menu_month] || DateTime.current.month
		@menu_day   = params[:menu_day]   || DateTime.current.day
		@menu_year  = params[:menu_year]  || DateTime.current.year
		@menu_date  = Time.zone.parse("#{@menu_year}-#{@menu_month}-#{@menu_day}")  	
		
		@user = User.find( params[:user_id] )
		start_date, end_date = SystemMailer.get_daily_interval( @menu_date.to_s )
		teachings = Teaching.between_dates( start_date, end_date ).teacher(@user.id).group_by(&:teacher_id)
		@schedule = SystemMailer.get_schedule( teachings[@user.id], @user )
  end

end
