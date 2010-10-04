class Recipient < ActiveRecord::Base
	validates_uniqueness_of :mail_id, :scope => :user_id
	belongs_to :mail
	belongs_to :user
	
	def name
		user.name
	end
end

# == Schema Information
#
# Table name: recipients
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  mail_id    :integer(4)
#  read       :boolean(1)      default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

