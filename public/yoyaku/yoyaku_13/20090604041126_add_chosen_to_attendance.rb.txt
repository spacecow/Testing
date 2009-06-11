class AddChosenToAttendance < ActiveRecord::Migration
  def self.up
    add_column :attendances, :chosen, :boolean, :default=>0
  end

  def self.down
    remove_column :attendances, :chosen
  end
end
