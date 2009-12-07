class CreateKanjisKunyomis < ActiveRecord::Migration
  def self.up
    create_table :kanjis_kunyomis, :id => false do |t|
      t.integer :kanji_id
      t.integer :kunyomi_id
    end
  end

  def self.down
    drop_table :kanjis_kunyomis
  end
end
