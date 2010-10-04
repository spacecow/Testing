class ScheduledUnit < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :unit

	validates_presence_of :date, :start_time, :end_time

	def abbr_day
		I18n.t('date.abbr_day_names')[ date.strftime("%w").to_i ]
	end

	def equals( _date, _start_time, _end_time )
		date.strftime("%m") == _date.strftime("%m") &&
		date.strftime("%d") == _date.strftime("%d") &&
		start_time == _start_time && end_time == _end_time
	end

	def date_and_time_interval
		date.strftime("%m")+"/"+date.strftime("%d")+": "+time_interval
	end
	
  def time_interval
    start_time.to_s(:time)+"~"+end_time.to_s(:time)
  end
  
  def short_date
  	date.strftime("%m") + "/" + date.strftime("%d")
  end
  
  def to_s
		short_date+" "+abbr_day+" "+time_interval
	end
end

# == Schema Information
#
# Table name: scheduled_units
#
#  id          :integer(4)      not null, primary key
#  schedule_id :integer(4)
#  unit_id     :integer(4)
#  start_time  :time
#  end_time    :time
#  date        :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

