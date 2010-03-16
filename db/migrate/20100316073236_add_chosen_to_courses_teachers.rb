class AddChosenToCoursesTeachers < ActiveRecord::Migration
  def self.up
    add_column :courses_teachers, :chosen, :boolean, :default => false
  end

  def self.down
    remove_column :courses_teachers, :chosen
  end
end
