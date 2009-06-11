class CreateCourseTimes < ActiveRecord::Migration
  def self.up
    create_table :course_times do |t|
      t.time :start_time
      t.time :end_time
      t.string :text

      t.timestamps
    end
  end

  def self.down
    drop_table :course_times
  end
end
