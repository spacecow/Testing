class Schedule < ActiveRecord::Base
	has_many :units

  attr_accessible :title, :description, :note
end
