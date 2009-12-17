class DeleteVotesFromTodos < ActiveRecord::Migration
  def self.up
  	remove_column :todos, :votes
  end

  def self.down
  	add_column :todos, :votes, :integer
  end
end
