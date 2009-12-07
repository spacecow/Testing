class AddTitleToKanjis < ActiveRecord::Migration
  def self.up
    add_column :kanjis, :title, :string
  end

  def self.down
    remove_column :kanjis, :title
  end
end
