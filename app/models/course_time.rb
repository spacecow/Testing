class CourseTime < ActiveRecord::Base
  has_many :template_classes
  
  def interval
    start_time.to_s(:time)+"~"+end_time.to_s(:time)
  end
    
  def to_s
    "#{self.start_time.to_s( :time )} -- #{self.end_time.to_s( :time )}"
  end
end

# == Schema Information
#
# Table name: course_times
#
#  id         :integer(4)      not null, primary key
#  start_time :time
#  end_time   :time
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

