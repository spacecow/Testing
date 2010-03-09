class CreateCoursesTeachers < ActiveRecord::Migration
  def self.up
    create_table :courses_teachers do |t|
      t.integer :teacher_id
      t.integer :course_id
      t.integer :cost

      t.timestamps
    end
  end

  def self.down
    drop_table :courses_teachers
  end
end
