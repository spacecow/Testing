class CreateGlossaries < ActiveRecord::Migration
  def self.up
    create_table :glossaries do |t|
      t.string :japanese
      t.string :hiragana
      t.string :kanji
      t.string :english
      t.timestamps
    end
  end
  
  def self.down
    drop_table :glossaries
  end
end
