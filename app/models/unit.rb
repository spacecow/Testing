class Unit < ActiveRecord::Base
	belongs_to :schedule

  attr_accessible :unit, :title, :page, :grammar_unit, :description, :note, :schedule_id
  
  validates_presence_of :schedule_id
end
