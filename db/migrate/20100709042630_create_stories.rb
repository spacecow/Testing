class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.text :japanese
      t.text :english
      t.timestamps
    end
  end
  
  def self.down
    drop_table :stories
  end
end
