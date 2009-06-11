class CreateAttendances < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.references :student
      t.references :klass
      t.boolean :cancel
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :attendances
  end
end
