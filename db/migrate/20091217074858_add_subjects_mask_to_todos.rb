class AddSubjectsMaskToTodos < ActiveRecord::Migration
  def self.up
    add_column :todos, :subjects_mask, :integer
  end

  def self.down
    remove_column :todos, :subjects_mask
  end
end
