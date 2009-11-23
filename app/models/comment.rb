class Comment < ActiveRecord::Base
	belongs_to :event
	
	validates_presence_of :comment, :event_id, :name
end
