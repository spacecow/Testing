class Schedule < ActiveRecord::Base
	has_many :units
	has_many :scheduled_units
	belongs_to :course

  attr_accessible :title, :description, :note, :course_id, :scheduled_unit_attributes
  
  validates_uniqueness_of :course_id
  validates_presence_of :course_id

	after_update :save_scheduled_units

	named_scope :course, lambda { |name| { :conditions=>[ "courses.name=?",name ], :include=>:course }}  

	def course_name
		course.name
	end

	def scheduled_unit_attributes=( scheduled_unit_attributes )
		scheduled_units.reject(&:new_record?).each do |scheduled_unit|
			scheduled_unit.attributes = scheduled_unit_attributes[ scheduled_unit.id.to_s ]
		end
	end

	def scheduled_units_equals( _date, _start_time, _end_time )
		scheduled_units.each do |unit|
			return true if unit.equals( _date, _start_time, _end_time	)
		end
		false
	end

	def get_scheduled_unit( _date, _start_time, _end_time )
		scheduled_units.each do |unit|
			return unit if unit.equals( _date, _start_time, _end_time	)
		end
		nil
	end

	def save_scheduled_units
		scheduled_units.each do |scheduled_unit|
			scheduled_unit.save( false )
		end
	end
end