class AddJapaneseToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :title_ja, :string
    add_column :events, :description_ja, :text
    add_column :events, :title_en, :string
    add_column :events, :description_en, :text
    remove_column :events, :title
    remove_column :events, :description
  end

  def self.down
    remove_column :events, :description_en
    remove_column :events, :title_en
    remove_column :events, :description_ja
    remove_column :events, :title_ja
    add_column :events, :title, :string
    add_column :events, :description, :text
  end
end
