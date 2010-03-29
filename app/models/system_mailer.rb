class SystemMailer < ActionMailer::Base

	def self.send_teacher_schedule( start_date, end_date, function, title )
		teachings = Teaching.all(
		  :conditions=>["klass_id = klasses.id and klasses.date >= ? and klasses.date < ?", start_date, end_date],
		  :include=>[:klass,:teacher] ).group_by(&:teacher)
		  
		teachings.each do |user,value|
			schedule = teachings[user].
				sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}.
				map(&:to_s).join("\n")
			func = "deliver_#{function}".to_sym
			SystemMailer.send( func, user, title, schedule )
		end	
	end

#=========================== Teachers

#---------------- Weekly schedule

	def self.next_weeks_teacher_schedule
		next_weeks_teacher_schedule_from(( Date.current + 1.day ).strftime( "%Y-%m-%d" ))
	end

	def self.next_weeks_teacher_schedule_from( date )
		start_date = Date.parse( date )
		start_date += 1.day while start_date.strftime("%a") != "Mon"
		send_teacher_schedule( start_date, start_date + 7.day, "weekly_schedule", "来週のシフトについて" )
	end

	def weekly_schedule( user, title, schedule )
    recipients  user.email
    from        "Yoyaku@GAKUWARINET.com"
    subject     title
    body        :schedule => schedule
	end

#---------------- Daily reminder

	def self.daily_teacher_reminder
		daily_teacher_reminder_from( Date.current.strftime( "%Y-%m-%d" ))
	end

  def self.daily_teacher_reminder_for( date )
  	todays_date = Date.parse( date )
		send_teacher_schedule( todays_date, todays_date + 1.day, "daily_english_teacher_reminder", "reminder" )
	end

	def daily_english_teacher_reminder( user, title, schedule )
    recipients  user.email
    from        "Yoyaku@GAKUWARINET.com"
    subject     title
    body        :schedule => schedule
	end	
end
