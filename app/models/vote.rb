class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :todo
	
	attr_accessible :user_id, :todo_id, :points
	validates_presence_of :user_id, :todo_id, :points
	validates_uniqueness_of :user_id, :scope => :todo_id
end
