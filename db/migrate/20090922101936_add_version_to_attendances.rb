class AddVersionToAttendances < ActiveRecord::Migration
  def self.up
    add_column :attendances, :version, :integer, :default => 1
  end

  def self.down
    remove_column :attendances, :version
  end
end
