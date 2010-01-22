class Recipient < ActiveRecord::Base
	validates_uniqueness_of :mail_id, :scope => :user_id
	belongs_to :mail
	belongs_to :user
end
