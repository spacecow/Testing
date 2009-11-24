class AddRolesMaskToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :roles_mask, :integer
    add_column :users, :roles, :string
  end

  def self.down
    remove_column :users, :roles_mask
    remove_column :users, :string
  end
end
