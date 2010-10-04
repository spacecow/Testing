class Unit < ActiveRecord::Base
	belongs_to :schedule
  has_one :scheduled_unit

  attr_accessible :unit, :title, :page, :grammar_unit, :description, :note, :schedule_id
  
  validates_presence_of :schedule_id
  validates_uniqueness_of :unit	

	def course_name
		schedule.course_name
	end
end

# == Schema Information
#
# Table name: units
#
#  id           :integer(4)      not null, primary key
#  unit         :string(255)
#  schedule_id  :integer(4)
#  title        :string(255)
#  page         :string(255)
#  grammar_unit :string(255)
#  description  :text
#  note         :text
#  created_at   :datetime
#  updated_at   :datetime
#

