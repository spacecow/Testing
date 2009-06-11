class AddStatusToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :status, :integer, :limit=>2
  end

  def self.down
    remove_column :people, :status
  end
end
