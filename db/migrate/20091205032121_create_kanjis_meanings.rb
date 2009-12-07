class CreateKanjisMeanings < ActiveRecord::Migration
  def self.up
    create_table :kanjis_meanings, :id => false do |t|
      t.integer :kanji_id
      t.integer :meaning_id
    end
  end

  def self.down
    drop_table :kanjis_meanings
  end
end
