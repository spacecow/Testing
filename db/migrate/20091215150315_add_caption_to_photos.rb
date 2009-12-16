class AddCaptionToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :caption_ja, :string
    add_column :photos, :caption_en, :string
    remove_column :photos, :caption
  end

  def self.down
    remove_column :photos, :caption_en
    remove_column :photos, :caption_ja
    add_column :photos, :caption, :string
  end
end
