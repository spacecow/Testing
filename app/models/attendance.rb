class Attendance < ActiveRecord::Base
  belongs_to :student, :class_name => 'User'
  belongs_to :klass
  
  def student_id=(student)
    super(student) unless student==""
  end
  
  def student_gender
    student.gender
  end
  
  def student_name
    student.name
  end
  
  def date
  	klass.date
  end
  
  def time_interval
  	klass.time_interval
  end
end
