class AddAndRemoveFieldsToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :hashed_password, :string
    add_column :people, :salt, :string
    add_column :people, :check, :string
    remove_column :people, :password
  end

  def self.down
    remove_column :people, :check
    remove_column :people, :salt
    remove_column :people, :hashed_password
    add_column :people, :password, :string
  end
end
