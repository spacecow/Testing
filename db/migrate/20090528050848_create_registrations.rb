class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.references :student
      t.references :course
      t.boolean :cancel
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :registrations
  end
end
