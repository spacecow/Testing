class AddCurrentToTeachings < ActiveRecord::Migration
  def self.up
    add_column :teachings, :current, :boolean
  end

  def self.down
    remove_column :teachings, :current
  end
end
