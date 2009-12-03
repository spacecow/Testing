class Comment < ActiveRecord::Base
	belongs_to :event
	belongs_to :user
	
	validates_presence_of :comment, :event_id, :user_id
end
