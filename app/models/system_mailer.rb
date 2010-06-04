class SystemMailer < ActionMailer::Base
	TYPES = %w[daily_teacher_reminder weekly_teacher_schedule last_months_salary_teacher_summary]

	def self.get_main_course( user )
		get_frequent_word( user.teacher_courses.map(&:category))
	end
	
	def self.get_frequent_word( words )
		hash = {}; max=0; res=0
			words.each{|w|
				hash[w] = ( hash[w] || 0 )+1
				if( hash[w] > max )
					max = hash[w]
					res = w
				end
			}
			res	
	end

	def self.get_summary( teachings, user, language = user.language )
		return nil if teachings.nil?
		schedule = ""
		main_course = get_main_course( user )
		date_teachings = teachings.group_by(&:date)
		date_teachings.keys.sort.each_with_index do |date,index|
			schedule += date_teachings[date][0].to_mail_date(language)+" "
			schedule += date_teachings[date].
				sort_by(&:time_interval).
				map(&:japanese_time_interval).join(", ") + "=" +
				date_teachings[date].map(&:hours).sum.to_s+"時間"
			schedule += "\n" unless (index+1)==date_teachings.keys.size
		end
		schedule
	end

	def self.get_schedule( teachings, user, language = user.language )
		return nil if teachings.nil?
		schedule = ""
		main_course = get_main_course( user )
		date_teachings = teachings.group_by(&:date)
		date_teachings.keys.sort.each_with_index do |date,index|
			schedule += date_teachings[date][0].to_mail_date(language)+" "
			schedule += date_teachings[date].
				sort_by(&:time_interval).
				map{|e| e.to_time_interval_course(main_course, language)}.join(", ")
			schedule += "\n" unless (index+1)==date_teachings.keys.size
		end
		schedule
	end

	def self.send_teacher_schedule( grouped_teachings, function, address, sender, date )
		grouped_teachings.each do |user_id,value|
		  user = User.find( user_id )
			schedule = get_schedule( grouped_teachings[user_id], user )
			func = "deliver_#{function}_#{user.language=='en' ? 'in_english' : 'in_japanese'}".to_sym
			SystemMailer.send( func, user, schedule, address, sender, date )
		end	
	end
	
	def self.send_salary_summary( grouped_teachings, function, address, confirm_date )
		grouped_teachings.each do |user_id,value|
		  teachings = grouped_teachings[user_id]
		  user = User.find( user_id )
			summary = get_summary( teachings, user )
			func = "deliver_#{function}_#{user.language=='en' ? 'in_english' : 'in_japanese'}".to_sym
			SystemMailer.send( func, teachings, user, summary, address, confirm_date )
		end			
	end

#=========================== Teachers

#---------------- Daily reminder

	def self.get_daily_interval( date )
		[Time.zone.parse( date ), Time.zone.parse( date )+1.day]
	end

	def self.get_daily_teachings_at( date )
		start_date, end_date = get_daily_interval( date )
		Teaching.between_dates( start_date, end_date ).current.confirmed.untaught
	end
	
	def self.get_daily_staff_teachings_at( date )
		get_daily_teachings_at( date ).staff
	end

	def self.get_daily_teachings_to_at( teacher, date )
		get_daily_teachings_at( date ).teacher(teacher.id)
	end



private
	def self.daily_teacher_reminder_with( grouped_teachings, address, sender, date )
	  send_teacher_schedule( grouped_teachings, "daily_teacher_reminder", address, sender, date )
  end

	def self.daily_grouped_teacher_reminder( teachings, address, sender, date )
		daily_teacher_reminder_with( teachings.group_by(&:teacher_id), address, sender, date )
	end

public	
	def self.daily_staff_reminder( address=nil, sender="Hitomi" )
		daily_staff_reminder_at( Time.zone.now.strftime( "%Y-%m-%d" ), address, sender )
	end	

	def self.daily_staff_reminder_as_johan_test
		daily_staff_reminder( "jsveholm@gmail.com" )
	end

	def self.daily_staff_reminder_as_yoyaku_test
		daily_staff_reminder( "Yoyaku@GAKUWARINET.com" )
	end

	def self.daily_staff_reminder_from_automagic_johan
		daily_staff_reminder( nil, "Automagic Johan" )
	end
	
	def self.daily_staff_reminder_as_johan_test_from_automagic_johan
		daily_staff_reminder( "jsveholm@gmail.com", "Automagic Johan" )
	end
	
	def self.daily_staff_reminder_as_yoyaku_test_from_automagic_johan
		daily_staff_reminder( "Yoyaku@GAKUWARINET.com", "Automagic Johan" )
	end
	
	def self.daily_staff_reminder_at( date, address=nil, sender="Hitomi" )
  	daily_grouped_teacher_reminder( get_daily_staff_teachings_at( date ), address, sender, Time.zone.parse( date ))
	end	


	def self.daily_teacher_reminder( address=nil )
		daily_teacher_reminder_at( Time.zone.now.strftime( "%Y-%m-%d" ), address )
	end

	def self.daily_teacher_reminder_as_johan_test
		daily_teacher_reminder( "jsveholm@gmail.com" )
	end

	def self.daily_teacher_reminder_as_yoyaku_test
		daily_teacher_reminder( "Yoyaku@GAKUWARINET.com" )
	end
	
  def self.daily_teacher_reminder_at( date, address=nil, sender="Hitomi" )
  	daily_grouped_teacher_reminder( get_daily_teachings_at( date ), address, sender, Time.zone.parse( date ))
	end

  def self.daily_teacher_reminder_to_at( teacher, date, address=nil, sender="Hitomi" )
  	daily_grouped_teacher_reminder( get_daily_teachings_to_at( teacher, date ), address, sender, Time.zone.parse( date ))
	end


	def self.next_working_days_teacher_reminder( address=nil )
		next_working_days_teacher_reminder_at( Time.zone.now.strftime( "%Y-%m-%d" ), address )
	end

	def self.next_working_days_teacher_reminder_as_yoyaku_test
		next_working_days_teacher_reminder( "Yoyaku@GAKUWARINET.com" )
	end	

	def self.next_working_days_teacher_reminder_as_johan_test
		next_working_days_teacher_reminder( "jsveholm@gmail.com" )
	end	

	def self.next_working_days_teacher_reminder_at( date, address=nil )
		5.times do |i|
			next_date = "#{(Time.zone.parse( date )+i.day).strftime( "%Y-%m-%d" )} 15" #only year-month-day 15
			daily_teacher_reminder_at(( Time.zone.parse(next_date)+1.day ).strftime( "%Y-%m-%d" ), address ) and return if Klass.find_by_date( next_date )
		end
	end
	
	
	def daily_teacher_reminder_in_english( user, schedule, address, sender, date )
    recipients  address.nil? ? user.email : address
    from        "Yoyaku@GAKUWARINET.com"
    subject     "Reminder #{date.month}/#{date.day}"
    body        :schedule => schedule, :name => (address.nil? ? "" : user.name), :sender => sender
	end	

	def daily_teacher_reminder_in_japanese( user, schedule, address, sender, date )
    recipients  address.nil? ? user.email : address
    from        "Yoyaku@GAKUWARINET.com"
    subject     "本日のスケジュール #{date.month}/#{date.day}"
    body        :schedule => schedule, :name => (address.nil? ? "" : user.name), :sender => sender
	end

#---------------- Monthly Salary

	def self.get_last_months_interval( date )
		[(Time.zone.parse( date )-1.month).beginning_of_month, (Time.zone.parse( date )-1.month).end_of_month]
	end
	
	def self.get_last_months_salary_teachings_at( date )
		start_date, end_date = get_last_months_interval( date )
		Teaching.between_dates( start_date, end_date ).current.confirmed.taught.non_staff
	end	
	
	def self.get_last_months_salary_teachings_to_at( teacher, date )
		get_last_months_salary_teachings_at( date ).teacher(teacher.id)
	end

private
	def self.last_months_salary_summary_with( grouped_teachings, address, confirm_date )
	  send_salary_summary( grouped_teachings, "last_months_salary_teacher_summary", address, confirm_date )
  end

	def self.last_months_grouped_salary_summary( teachings, address, confirm_date )
		last_months_salary_summary_with( teachings.group_by(&:teacher_id), address, confirm_date )
	end
	
public
	def self.get_last_months_interval( date )
		[(Time.zone.parse( date )-1.month).beginning_of_month, (Time.zone.parse( date )-1.month).end_of_month]
	end

	def self.last_months_salary_summary( address=nil )
		last_months_salary_summary_at( Time.zone.now.strftime( "%Y-%m-%d" ), address )
	end

	def self.last_months_salary_summary_as_johan_test
		last_months_salary_summary( "jsveholm@gmail.com" )
	end

	def self.last_months_salary_summary_as_yoyaku_test
		last_months_salary_summary( "Yoyaku@GAKUWARINET.com" )
	end

	

	def self.last_months_salary_summary_at( date, address=nil )
		last_months_grouped_salary_summary( get_last_months_salary_teachings_at( date ), address, Time.zone.now.beginning_of_month+5.day )
	end
	
	def last_months_salary_teacher_summary_in_english( teachings, user, summary, address, confirm_date )
    this_month  = confirm_date.strftime("%B")
    last_month  = (confirm_date-1.month).strftime("%B")
    confirm_day = confirm_date.strftime("%a")
		hours 				= teachings.map(&:hours).sum
		teaching_cost	= teachings.map{|e| e.cost.to_i}.sum
		teaching_days = teachings.group_by(&:date).size
		total_traveling_expenses = teaching_days*user.traveling_expenses.to_i
		total_cost		= teaching_cost + total_traveling_expenses
		if user.traveling_expenses.to_i > 0
			traveling_expenses = "Traveling expenses: #{user.traveling_expenses}y×#{teaching_days.to_s}days=#{total_traveling_expenses}y"
		else
			traveling_expenses = ""
		end		
    recipients  address.nil? ? user.email : address
    from        "Yoyaku@GAKUWARINET.com"
    subject     "#{last_month}'s Salary, Please confirm"
    body        :summary => summary, :name => (address.nil? ? "" : user.name), :last_month => last_month, :this_month => this_month, :confirm_day => confirm_day, :teacher => user.name, :yen_per_h => user.cost, :total_cost => total_cost, :hours => hours, :teaching_cost => teaching_cost, :bank_name => user.bank.first.name.to_s, :bank_branch => user.bank.first.branch.to_s, :bank_account => user.bank.first.account.to_s, :bank_signup_name => user.bank.first.signup_name.to_s, :traveling_expenses => traveling_expenses
	end	
	
	def last_months_salary_teacher_summary_in_japanese( teachings, user, summary, address, confirm_date )
    this_month  = confirm_date.month
    last_month  = ( confirm_date-1.month ).month
    confirm_day = confirm_date.wday
		hours 				= teachings.map(&:hours).sum
		teaching_cost	= teachings.map{|e| e.cost.to_i}.sum
		teaching_days = teachings.group_by(&:date).size
		total_traveling_expenses = teaching_days*user.traveling_expenses.to_i
		total_cost		= teaching_cost + total_traveling_expenses		
		if user.traveling_expenses.to_i > 0
			traveling_expenses = "交通: #{user.traveling_expenses}円×#{teaching_days.to_s}日=#{total_traveling_expenses}円"
		else
			traveling_expenses = ""
		end		
    recipients  address.nil? ? user.email : address
    from        "Yoyaku@GAKUWARINET.com"
    subject     "確認お願いします＿#{last_month}月分賃金"
    body        :summary => summary, :name => (address.nil? ? "" : user.name), :last_month => last_month, :this_month => this_month, :confirm_day => confirm_day, :teacher => user.name, :yen_per_h => user.cost, :total_cost => total_cost, :hours => hours, :teaching_cost => teaching_cost, :bank_name => user.bank.first.name.to_s, :bank_branch => user.bank.first.branch.to_s, :bank_account => user.bank.first.account.to_s, :bank_signup_name => user.bank.first.signup_name.to_s, :traveling_expenses => traveling_expenses
	end		


#---------------- Weekly schedule

	def self.get_weekly_interval_at( date )
		start_date = Time.zone.parse( date )+1.day
		start_date += 1.day while start_date.strftime("%a") != "Mon"
		end_date = start_date + 7.day
		[start_date, end_date]
	end
	
	def self.get_weekly_teachings_at( date )
		start_date, end_date = get_weekly_interval_at( date )
		Teaching.between_dates( start_date, end_date ).current.not_declined
	end
	
	def self.get_weekly_teachings_to_at( teacher, date )
		get_weekly_teachings_at( date ).teacher(teacher.id)
	end


private
	def self.weekly_teacher_schedule_with( grouped_teachings, address, sender, date )
		send_teacher_schedule( grouped_teachings, "weekly_teacher_schedule", address, sender, date )
	end

	def self.weekly_grouped_teacher_schedule( teachings, address, sender, date )
		weekly_teacher_schedule_with( teachings.group_by(&:teacher_id), address, sender, date )
	end


public
	def self.next_weeks_teacher_schedule( address=nil )
		weekly_teacher_schedule_at(( Time.zone.now ).strftime( "%Y-%m-%d" ), address )
	end
	
	def self.next_weeks_teacher_schedule_as_johan_test
		next_weeks_teacher_schedule( "jsveholm@gmail.com" )
	end
	
	def self.next_weeks_teacher_schedule_as_yoyaku_test
		next_weeks_teacher_schedule( "Yoyaku@GAKUWARINET.com" )
	end		

	def self.weekly_teacher_schedule_at( date, address=nil, sender='Hitomi' )
		weekly_grouped_teacher_schedule( get_weekly_teachings_at( date ), address, sender, Time.zone.parse( date ))
	end

	def self.weekly_teacher_schedule_to_at( teacher, date, address=nil, sender='Hitomi')
		weekly_grouped_teacher_schedule( get_weekly_teachings_to_at( teacher, date ), address, sender, Time.zone.parse( date ))
	end
	


	def weekly_teacher_schedule_in_english( user, schedule, address, sender, date )
    recipients  address.nil? ? user.email : address
    from        "Yoyaku@GAKUWARINET.com"
    subject     "Schedule for next week"
    body        :schedule => schedule, :name => (address.nil? ? "" : user.name), :sender => sender
	end
	
	def weekly_teacher_schedule_in_japanese( user, schedule, address, sender, date )
    recipients  address.nil? ? user.email : address
    from        "Yoyaku@GAKUWARINET.com"
    subject     "来週のシフトについて"
    body        :schedule => schedule, :name => (address.nil? ? "" : user.name), :sender => sender
	end
end