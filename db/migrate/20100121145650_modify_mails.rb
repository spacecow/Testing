class ModifyMails < ActiveRecord::Migration
  def self.up
  	remove_column :mails, :recipient_id
  	remove_column :mails, :read
  end

  def self.down
  	add_column :mails, :recipient_id, :integer
  	add_column :mails, :read, :boolean, :default => false
  end
end
