class AddLateToAttendances < ActiveRecord::Migration
  def self.up
    add_column :attendances, :late, :boolean, :default => false
  end

  def self.down
    remove_column :attendances, :late
  end
end
