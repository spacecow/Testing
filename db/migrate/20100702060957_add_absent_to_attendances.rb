class AddAbsentToAttendances < ActiveRecord::Migration
  def self.up
    add_column :attendances, :absent, :boolean, :default=>false
  end

  def self.down
    remove_column :attendances, :absent
  end
end
