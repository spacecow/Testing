class SystemMailer < ActionMailer::Base

	def self.send_teacher_schedule( teachings, function, title )
		teachings.each do |user,value|
			schedule = teachings[user].
				sort{|a,b| a.date==b.date ? a.time_interval<=>b.time_interval : a.date<=>b.date}.
				map(&:to_s).join("\n")
			func = "deliver_#{function}".to_sym
			SystemMailer.send( func, user, title, schedule )
		end	
	end

	def self.get_teachings( start_date, end_date )
		Teaching.all(
		  :conditions=>["klass_id = klasses.id and klasses.date >= ? and klasses.date < ?", start_date, end_date],
		  :include=>[:klass,:teacher] ).group_by(&:teacher)
	end

	def self.get_teachings_to( start_date, end_date, teacher )
		Teaching.all(
		  :conditions=>["teacher_id = ? and klass_id = klasses.id and klasses.date >= ? and klasses.date < ?", teacher.id, start_date, end_date],
		  :include=>[:klass,:teacher] ).group_by(&:teacher)
	end


#=========================== Teachers

#---------------- Daily reminder

	def self.daily_teacher_reminder
		daily_teacher_reminder_at( Date.current.strftime( "%Y-%m-%d" ))
	end

  def self.daily_teacher_reminder_at( date )
  	todays_date = Date.parse( date )
  	teachings = get_teachings( todays_date, todays_date + 1.day )
		send_teacher_schedule( teachings, "daily_english_teacher_reminder", "reminder" )
	end

  def self.daily_teacher_reminder_to_at( teacher, date )
  	todays_date = Date.parse( date )
  	teachings = get_teachings_to( todays_date, todays_date + 1.day, teacher )
		send_teacher_schedule( teachings, "daily_english_teacher_reminder", "reminder" )
	end

	def daily_english_teacher_reminder( user, title, schedule )
    recipients  "Yoyaku@GAKUWARINET.com" #user.email
    from        "Yoyaku@GAKUWARINET.com"
    subject     title
    body        :schedule => schedule
	end	

#---------------- Weekly schedule

	def self.next_weeks_teacher_schedule
		weekly_teacher_schedule_from(( Date.current + 1.day ).strftime( "%Y-%m-%d" ))
	end

	def self.weekly_teacher_schedule_from( date )
		start_date = Date.parse( date )
		start_date += 1.day while start_date.strftime("%a") != "Mon"
		teachings = get_teachings( start_date, start_date + 7.day )
		send_teacher_schedule( teachings, "weekly_schedule", "来週のシフトについて" )
	end

	def self.weekly_teacher_schedule_to_from( teacher, date )
		start_date = Date.parse( date )
		start_date += 1.day while start_date.strftime("%a") != "Mon"
		teachings = get_teachings_to( start_date, start_date + 7.day, teacher )
		send_teacher_schedule( teachings, "weekly_schedule", "来週のシフトについて" )
	end


	def weekly_schedule( user, title, schedule )
    recipients  "Yoyaku@GAKUWARINET.com" #user.email
    from        "Yoyaku@GAKUWARINET.com"
    subject     title
    body        :schedule => schedule
	end
end