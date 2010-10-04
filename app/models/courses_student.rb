class CoursesStudent < ActiveRecord::Base
  #belongs_to :student, :class_name => 'User'
  #belongs_to :course
  
	attr_accessible :course_id, :student_id
	validates_presence_of :course_id, :student_id
	validates_uniqueness_of :course_id, :scope => :student_id  
end

# == Schema Information
#
# Table name: courses_students
#
#  student_id :integer(4)
#  course_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

