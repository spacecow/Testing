class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.string :title

      t.timestamps
    end
    add_column :glossaries, :theme_id, :integer
  end

  def self.down
    drop_table :themes
    remove_column :glossaries, :theme_id
  end
end
