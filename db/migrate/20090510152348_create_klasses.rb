class CreateKlasses < ActiveRecord::Migration
  def self.up
    create_table :klasses do |t|
      t.references :course
      t.references :teacher
      t.references :classroom
      t.integer :capacity
      t.datetime :date
      t.time :start_time
      t.time :end_time
      t.string :title
      t.text :description
      t.boolean :cancel
      t.integer :mail_sending
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :klasses
  end
end
