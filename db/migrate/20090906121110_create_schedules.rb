class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.references :course
      t.text :description
      t.text :note
      t.timestamps
    end
  end
  
  def self.down
    drop_table :schedules
  end
end
