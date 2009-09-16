class Schedule < ActiveRecord::Base
	has_many :units
	belongs_to :course

  attr_accessible :title, :description, :note, :course_id
  
  validates_uniqueness_of :course_id
  validates_presence_of :course_id
end
