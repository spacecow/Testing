class CreateKanjis < ActiveRecord::Migration
  def self.up
    create_table :kanjis do |t|
      t.string :japanese
      t.string :katakana
      t.string :kanji
      t.string :english
      t.timestamps
    end
  end
  
  def self.down
    drop_table :kanjis
  end
end
