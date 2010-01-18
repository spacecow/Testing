class Mail < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  
  attr_accessible :recipient_id, :sender_id, :subject, :message, :read
  
  validate :recipient_should_be_present
  validate :sender_should_be_present
  
  before_save :assure_subject_is_not_blank

private
	def recipient_should_be_present
		errors.add :recipient, I18n.t('activerecord.errors.messages.blank') if recipient_id == nil
	end
	def sender_should_be_present
		errors.add :sender, I18n.t('activerecord.errors.messages.blank') if sender_id == nil
	end
	
	def assure_subject_is_not_blank
		self.subject = "no_subject" if subject.blank?
	end
end
