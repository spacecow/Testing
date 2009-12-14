class AddVersionToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :version, :string
  end

  def self.down
    remove_column :settings, :version
  end
end
