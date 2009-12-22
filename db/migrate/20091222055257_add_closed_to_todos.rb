class AddClosedToTodos < ActiveRecord::Migration
  def self.up
    add_column :todos, :closed, :boolean, :default => false
  end

  def self.down
    remove_column :todos, :closed
  end
end
