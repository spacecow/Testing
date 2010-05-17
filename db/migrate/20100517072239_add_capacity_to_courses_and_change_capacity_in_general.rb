class AddCapacityToCoursesAndChangeCapacityInGeneral < ActiveRecord::Migration
  def self.up
    add_column :courses, :capacity, :string
    remove_column :klasses, :capacity
    add_column :klasses, :capacity, :string
    remove_column :template_classes, :capacity
    add_column :template_classes, :capacity, :string
  end

  def self.down
    remove_column :courses, :capacity
    remove_column :klasses, :capacity
    add_column :klasses, :capacity, :integer
    remove_column :template_classes, :capacity
    add_column :template_classes, :capacity, :integer
  end
end
