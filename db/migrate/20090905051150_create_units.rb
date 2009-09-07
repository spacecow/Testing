class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.string :unit
      t.references :schedule
      t.string :title
      t.string :page
      t.string :grammar_unit
      t.text :description
      t.text :note
      t.timestamps
    end
  end
  
  def self.down
    drop_table :units
  end
end
