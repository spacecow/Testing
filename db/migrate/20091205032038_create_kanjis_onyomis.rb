class CreateKanjisOnyomis < ActiveRecord::Migration
  def self.up
    create_table :kanjis_onyomis, :id => false do |t|
      t.integer :kanji_id
      t.integer :onyomi_id
    end
  end

  def self.down
    drop_table :kanjis_onyomis
  end
end
