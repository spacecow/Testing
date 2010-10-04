class Mail < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User', :foreign_key => "sender_id"
  has_many :recipients, :dependent => :destroy
  has_many :users, :through => :recipients #:foreign_key => "recipient_id"
  
  attr_accessible :sender_id, :subject, :message, :user_ids, :mailing
  validates_presence_of :users, :if => :mailing #to allow cucumber to create new mails without filling in users first
	attr_accessor :mailing
  
  #validate :recipient_should_be_present
  validate :sender_must_be_present
  
  before_save :assure_subject_is_not_blank

private
	def recipient_should_be_present
		errors.add :recipient, I18n.t('activerecord.errors.messages.blank') if recipient_id == nil
	end
	def sender_must_be_present
		errors.add :sender, I18n.t('activerecord.errors.messages.blank') if sender_id == nil
	end
	
	def assure_subject_is_not_blank
		self.subject = "no_subject" if subject.blank?
	end
end

# == Schema Information
#
# Table name: mails
#
#  id         :integer(4)      not null, primary key
#  sender_id  :integer(4)
#  subject    :string(255)
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

