class AddLanguageToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :language, :string, :default => 'ja'
  end

  def self.down
    remove_column :people, :language
  end
end
