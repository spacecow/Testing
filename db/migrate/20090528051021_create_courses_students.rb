class CreateCoursesStudents < ActiveRecord::Migration
  def self.up
    create_table :courses_students, :id => false do |t|
      t.references :student
      t.references :course

      t.timestamps
    end
  end

  def self.down
    drop_table :courses_students
  end
end
