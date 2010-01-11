class CreateMails < ActiveRecord::Migration
  def self.up
    create_table :mails do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.string :subject
      t.text :message
      t.boolean :read, :default => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :mails
  end
end
