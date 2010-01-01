class AddInfoUpdateToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :info_update, :boolean, :default => true
  end

  def self.down
    remove_column :users, :info_update
  end
end
