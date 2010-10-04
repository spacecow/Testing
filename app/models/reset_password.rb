class ResetPassword < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :email, :username, :token, :user_id
	attr_accessor :username, :email

	validate :both_email_and_username_cannot_be_blank
	validate :username_must_exist
	validate :email_must_exist
	
	before_create :generate_token

private
	def both_email_and_username_cannot_be_blank
	  errors.add(:username, I18n.t('error.message.both_blank')) if username.blank? && email.blank?
	  errors.add(:email, I18n.t('error.message.both_blank')) if username.blank? && email.blank?
	end
	
	def username_must_exist
		errors.add :username, I18n.t('error.message.does_not_exist') if User.find_by_username( username ).nil? unless errors.on( :username ) || username.blank?
	end
	
	def email_must_exist
		errors.add :email, I18n.t('error.message.does_not_exist') if User.find_by_email( email ).nil? unless errors.on( :email ) || email.blank?
	end	
	
	def generate_token
		self.token = Digest::SHA1.hexdigest([ Time.now, rand ].join )	
	end	
end

# == Schema Information
#
# Table name: reset_passwords
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  token      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  used       :boolean(1)      default(FALSE)
#

