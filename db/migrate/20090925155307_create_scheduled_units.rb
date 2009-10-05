class CreateScheduledUnits < ActiveRecord::Migration
  def self.up
    create_table :scheduled_units do |t|
      t.references :schedule
      t.references :unit
      t.time :start_time
      t.time :end_time
      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :scheduled_units
  end
end
