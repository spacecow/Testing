class AddTravelingExpensesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :traveling_expenses, :string
  end

  def self.down
    remove_column :users, :traveling_expenses
  end
end
