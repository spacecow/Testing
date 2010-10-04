class AddWordIdToGlossary < ActiveRecord::Migration
  def self.up
    add_column :glossaries, :word_id, :integer
    remove_column :glossaries, :hiragana
    remove_column :glossaries, :kanji
  end

  def self.down
    remove_column :glossaries, :word_id
    add_column :glossaries, :hiragana, :string
    add_column :glossaries, :kanji, :string
  end
end
