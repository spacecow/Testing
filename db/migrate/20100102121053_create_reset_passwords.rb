class CreateResetPasswords < ActiveRecord::Migration
  def self.up
    create_table :reset_passwords do |t|
      t.integer :user_id
      t.string :token
      t.timestamps
    end
  end
  
  def self.down
    drop_table :reset_passwords
  end
end
