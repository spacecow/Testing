class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :todo
	
	attr_accessible :user_id, :todo_id, :points
	validates_presence_of :user_id, :todo_id, :points
	validates_uniqueness_of :user_id, :scope => :todo_id
end

# == Schema Information
#
# Table name: votes
#
#  id         :integer(4)      not null, primary key
#  todo_id    :integer(4)
#  user_id    :integer(4)
#  points     :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

