class AddAndChangeCost < ActiveRecord::Migration
  def self.up
  	add_column :users, :cost, :string
		remove_column :teachings, :cost
		add_column :teachings, :cost, :string
		remove_column :courses_teachers, :cost
		add_column :courses_teachers, :cost, :string
  end

  def self.down
  	remove_column :users, :cost
  	remove_column :teachings, :cost
  	add_column :teachings, :cost, :integer
  	remove_column :courses_teachers, :cost
  	add_column :courses_teachers, :cost, :integer
  end
end
