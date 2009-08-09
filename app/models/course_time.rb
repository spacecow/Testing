class CourseTime < ActiveRecord::Base
  has_many :template_classes
  
  def interval
    start_time.to_s(:time)+"~"+end_time.to_s(:time)
  end
    
  def to_s
    "#{self.start_time.to_s( :time )} -- #{self.end_time.to_s( :time )}"
  end
end
