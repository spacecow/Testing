class Klass < ActiveRecord::Base
  belongs_to :course
  belongs_to :teacher
  belongs_to :classroom
  #has_and_belongs_to_many :students
  has_many :attendances
  has_many :students, :through => :attendances
  
  validates_presence_of :course_id
  
  def time_interval
    start_time.to_s(:time)+"~"+end_time.to_s(:time)
  end
    
  def course_name
    course.name
  end
    
  def course_category
    course.category
  end
  
  def course_level
    course.level
  end   
  
  def teacher_gender
    teacher.gender
  end

  def to_s
    course_name + (": ") + time_interval
  end
end
