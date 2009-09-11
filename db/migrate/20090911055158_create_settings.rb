class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :name	
      t.integer :people_per_page
      t.string :language

      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
