class SystemMailer < ActionMailer::Base
	def self.get_main_course( teachings )
		hash = {}; max=0; res=0
			teachings.each{|e|
				hash[e.course_category] = ( hash[e.course_category] || 0 )+1
				if( hash[e.course_category] > max )
					max = hash[e.course_category]
					res = e.course_category
				end
			}
			res	
	end

	def self.send_teacher_schedule( teachings, function )
		schedule = ""
		teachings.each do |user,value|
			main_course = get_main_course( teachings[user] )
			date_teachings = teachings[user].group_by(&:date)
			date_teachings.keys.sort.each_with_index do |date,index|
				schedule += date_teachings[date][0].to_mail_date(user.language)+" "
				schedule += date_teachings[date].
					sort_by(&:time_interval).
					map{|e| e.to_mail_time_interval(main_course, user.language)}.join(", ")
				schedule += "\n" unless (index+1)==date_teachings.keys.size
			end
			func = "deliver_#{function}_#{user.language=='en' ? 'in_english' : 'in_japanese'}".to_sym
			SystemMailer.send( func, user, schedule )
		end	
	end
	
	#月, 火, 水, 木, 金, 土, 日

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
		daily_teacher_reminder_at( Time.zone.current.strftime( "%Y-%m-%d" ))
	end

  def self.daily_teacher_reminder_at( date )
  	todays_date = Time.zone.parse( date )
  	teachings = get_teachings( todays_date, todays_date + 1.day )
		send_teacher_schedule( teachings, "daily_teacher_reminder" )
	end

  def self.daily_teacher_reminder_to_at( teacher, date )
  	todays_date = Time.zone.parse( date )
  	teachings = get_teachings_to( todays_date, todays_date + 1.day, teacher )
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

	def self.next_weeks_teacher_schedule
		weekly_teacher_schedule_from(( Time.zone.current + 1.day ).strftime( "%Y-%m-%d" ))
	end

	def self.weekly_teacher_schedule_from( date )
		start_date, end_date = get_weekly_interval( date )
		teachings = get_teachings( start_date, end_date )
		weekly_teacher_schedule_with( teachings )
	end

	def self.weekly_teacher_schedule_to_from( teacher, date )
		start_date, end_date = get_weekly_interval( date )
		teachings = get_teachings_to( start_date, end_date, teacher )
		weekly_teacher_schedule_with( teachings )
	end
	
	def self.weekly_teacher_schedule_with( teachings )
		send_teacher_schedule( teachings, "weekly_teacher_schedule" )
	end

	def self.get_weekly_interval( date )
		start_date = Time.zone.parse( date )
		start_date += 1.day while start_date.strftime("%a") != "Mon"
		end_date = start_date + 7.day
		[start_date, end_date]
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
	
#private
#  # we override the template_path to render localized templates (since rails does not support that :-( )
#  # This thing is not testable since you cannot access the instance of a mailer...
#  def initialize_defaults(method_name)
#    super
#    @template = "#{I18n.locale}_#{method_name}"
#  end	
end