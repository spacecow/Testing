class AddRolesMaskToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :roles_mask, :integer
    add_column :users, :role, :string
  end

  def self.down
    remove_column :users, :roles_mask
    remove_column :users, :role
  end
end
