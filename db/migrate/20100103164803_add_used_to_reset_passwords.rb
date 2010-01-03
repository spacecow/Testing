class AddUsedToResetPasswords < ActiveRecord::Migration
  def self.up
    add_column :reset_passwords, :used, :boolean, :default => false
  end

  def self.down
    remove_column :reset_passwords, :used
  end
end
