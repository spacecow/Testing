class CreateTeachings < ActiveRecord::Migration
  def self.up
    create_table :teachings do |t|
      t.references :teacher
      t.references :course
      t.integer :cost, :default => 1500
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :teachings
  end
end
