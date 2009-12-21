class Comment < ActiveRecord::Base
	belongs_to :event
	belongs_to :user
	belongs_to :todo
	
	validates_presence_of :comment, :user_id
	validates_presence_of :event_id, :if => Proc.new { |thing| thing.todo_id.blank? }
	validates_presence_of :todo_id, :if => Proc.new { |thing| thing.event_id.blank? }
end
