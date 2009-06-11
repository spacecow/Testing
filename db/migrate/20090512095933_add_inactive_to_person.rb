class AddInactiveToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :inactive, :boolean
  end

  def self.down
    remove_column :people, :inactive
  end
end
