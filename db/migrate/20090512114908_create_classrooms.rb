class CreateClassrooms < ActiveRecord::Migration
  def self.up
    create_table :classrooms do |t|
      t.string :name
      t.string :address
      t.text :description
      t.boolean :inactive
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :classrooms
  end
end
