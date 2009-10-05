class ScheduledUnit < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :unit

	validates_presence_of :date, :start_time, :end_time

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
end
