class AddUserIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :user_id, :integer
    remove_column :comments, :name
  end

  def self.down
    remove_column :comments, :user_id
    add_column :comments, :name, :string
  end
end
