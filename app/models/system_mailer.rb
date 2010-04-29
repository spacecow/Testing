class SystemMailer < ActionMailer::Base
	TYPES = %w[daily_teacher_reminder weekly_teacher_schedule]

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

	def self.get_schedule( teachings, user, language = user.language )
		return nil if teachings.nil?
		schedule = ""
		main_course = get_main_course( user )
		date_teachings = teachings.group_by(&:date)
		date_teachings.keys.sort.each_with_index do |date,index|
			schedule += date_teachings[date][0].to_mail_date(language)+" "
			schedule += date_teachings[date].
				sort_by(&:time_interval).
				map{|e| e.to_mail_time_interval(main_course, language)}.join(", ")
			schedule += "\n" unless (index+1)==date_teachings.keys.size
		end
		schedule
	end

	def self.send_teacher_schedule( teachings, function )
		teachings.each do |user_id,value|
		  user = User.find( user_id )
			schedule = get_schedule( teachings[user_id], user )
			func = "deliver_#{function}_#{user.language=='en' ? 'in_english' : 'in_japanese'}".to_sym
			SystemMailer.send( func, user, schedule )
		end	
	end

#=========================== Teachers

#---------------- Daily reminder

	def self.get_daily_interval( date )
		[Time.zone.parse( date ), Time.zone.parse( date )+1.day]
	end

	def self.get_daily_teachings_at( date )
		start_date, end_date = get_daily_interval( date )
		Teaching.between_dates( start_date, end_date ).current.
			confirmed.untaught.group_by(&:teacher_id)
	end
	
	def self.get_daily_teachings_to_at( teacher, date )
		start_date, end_date = get_daily_interval( date )
		Teaching.between_dates( start_date, end_date ).current.
			confirmed.untaught.teacher(teacher.id).group_by(&:teacher_id)
	end


	def self.daily_teacher_reminder
		daily_teacher_reminder_at( Time.zone.now.strftime( "%Y-%m-%d" ))
	end

  def self.daily_teacher_reminder_at( date )
  	teachings = get_daily_teachings_at( date )  	
		daily_teacher_reminder_with( teachings )
	end

  def self.daily_teacher_reminder_to_at( teacher, date )
  	teachings = get_daily_teachings_to_at( teacher, date )
		daily_teacher_reminder_with( teachings )
	end
	
	def self.daily_teacher_reminder_with( teachings )
	  send_teacher_schedule( teachings, "daily_teacher_reminder" )
  end

	def daily_teacher_reminder_in_english( user, schedule )
    recipients  user.email
    from        "Yoyaku@GAKUWARINET.com"
    subject     "Reminder"
    body        :schedule => schedule
	end	

	def daily_teacher_reminder_in_japanese( user, schedule )
    recipients  user.email
    from        "Yoyaku@GAKUWARINET.com"
    subject     "mada"
    body        :schedule => schedule
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
		Teaching.between_dates( start_date, end_date ).current.
			not_declined.group_by(&:teacher_id)
	end
	
	def self.get_weekly_teachings_to_at( teacher, date )
		start_date, end_date = get_weekly_interval_at( date )
		Teaching.between_dates( start_date, end_date ).current.
			not_declined.teacher(teacher.id).group_by(&:teacher_id)
	end

	def self.next_weeks_teacher_schedule
		weekly_teacher_schedule_at(( Time.zone.now + 1.day ).strftime( "%Y-%m-%d" ))
	end

	def self.weekly_teacher_schedule_at( date )
		teachings = get_weekly_teachings_at( date )
		weekly_teacher_schedule_with( teachings )
	end

	def self.weekly_teacher_schedule_to_at( teacher, date )
		teachings = get_weekly_teachings_to_at( teacher, date )
		weekly_teacher_schedule_with( teachings )
	end
	
	def self.weekly_teacher_schedule_with( teachings )
		send_teacher_schedule( teachings, "weekly_teacher_schedule" )
	end

	def weekly_teacher_schedule_in_english( user, schedule )
    recipients  user.email
    from        "Yoyaku@GAKUWARINET.com"
    subject     "Schedule for next week"
    body        :schedule => schedule
	end
	
	def weekly_teacher_schedule_in_japanese( user, schedule )
    recipients  user.email
    from        "Yoyaku@GAKUWARINET.com"
    subject     "来週のシフトについて"
    body        :schedule => schedule
	end
end