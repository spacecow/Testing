class AddTodoIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :todo_id, :integer
  end

  def self.down
    remove_column :comments, :todo_id
  end
end
