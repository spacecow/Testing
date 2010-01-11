class Mail < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  
  attr_accessible :recipient_id, :sender_id, :subject, :message, :read
end
