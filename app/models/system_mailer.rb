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

	def self.send_teacher_schedule( teachings, function, title )
		schedule = ""
		teachings.each do |user,value|
			main_course = get_main_course( teachings[user] )
			date_teachings = teachings[user].group_by(&:date)
			date_teachings.keys.sort.each_with_index do |date,index|
				schedule += date_teachings[date][0].to_mail_date+" "
				schedule += date_teachings[date].
					sort_by(&:time_interval).
					map{|e| e.to_mail_time_interval(main_course)}.join(", ")
				schedule += "\n" unless (index+1)==date_teachings.keys.size
			end
			func = "deliver_#{function}".to_sym
			SystemMailer.send( func, user, title, schedule )
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
		daily_teacher_reminder_at( Date.current.strftime( "%Y-%m-%d" ))
	end

  def self.daily_teacher_reminder_at( date )
  	todays_date = Time.zone.parse( date )
  	teachings = get_teachings( todays_date, todays_date + 1.day )
		send_teacher_schedule( teachings, "daily_english_teacher_reminder", "reminder" )
	end

  def self.daily_teacher_reminder_to_at( teacher, date )
  	todays_date = Time.zone.parse( date )
  	teachings = get_teachings_to( todays_date, todays_date + 1.day, teacher )
		send_teacher_schedule( teachings, "daily_english_teacher_reminder", "reminder" )
	end

	def daily_english_teacher_reminder( user, title, schedule )
    recipients  user.email
    from        "Yoyaku@GAKUWARINET.com"
    subject     title
    body        :schedule => schedule
	end	

#---------------- Weekly schedule

	def self.next_weeks_teacher_schedule
		weekly_teacher_schedule_from(( Date.current + 1.day ).strftime( "%Y-%m-%d" ))
	end

	def self.weekly_teacher_schedule_from( date )
		start_date = Time.zone.parse( date )
		start_date += 1.day while start_date.strftime("%a") != "Mon"
		teachings = get_teachings( start_date, start_date + 7.day )
		send_teacher_schedule( teachings, "weekly_schedule", "来週のシフトについて" )
	end

	def self.weekly_teacher_schedule_to_from( teacher, date )
		start_date = Time.zone.parse( date )
		start_date += 1.day while start_date.strftime("%a") != "Mon"
		teachings = get_teachings_to( start_date, start_date + 7.day, teacher )
		send_teacher_schedule( teachings, "weekly_schedule", "来週のシフトについて" )
	end


	def weekly_schedule( user, title, schedule )
    recipients  user.email
    from        "Yoyaku@GAKUWARINET.com"
    subject     title
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