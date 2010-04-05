class CreateWords < ActiveRecord::Migration
  def self.up
    create_table :words do |t|
      t.string :japanese
      t.string :reading
      t.string :meaning
    end
  end
  
  def self.down
    drop_table :words
  end
end
