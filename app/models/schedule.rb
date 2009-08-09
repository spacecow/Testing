class Schedule
  def no_of_ten_minutes( start_time, end_time )
    start_parts = start_time.split( ':' )
    end_parts = end_time.split( ':' )
    minutes = no_of_minutes_from_hours( start_parts[0], end_parts[0] )
    ( minutes + end_parts[-1].to_i - start_parts[-1].to_i ) / 10
  end
  
	def no_of_minutes_from_hours( start_hour, end_hour )
	  ( end_hour.to_i - start_hour.to_i ) * 60
	end
	
	def whole_hour( time, ten_minutes )
    time_parts = time.split( ':' )
    ( ten_minutes * 10 + time_parts[-1].to_i + 60 ) % 60 == 0
  end
  
  def add_minutes( time, minutes )
    time_parts = time.split( ':' )
    hours = time_parts[0].to_i + ( minutes + time_parts[-1].to_i )/60;
    minutes = ( minutes + time_parts[-1].to_i )%60;
    minutes == 0 ? "#{hours}:00" : "#{hours}:#{minutes}"
  end
end