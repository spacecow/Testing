class Attendance < ActiveRecord::Base
  belongs_to :student
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
end
