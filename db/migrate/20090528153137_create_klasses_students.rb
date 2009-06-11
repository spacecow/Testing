class CreateKlassesStudents < ActiveRecord::Migration
  def self.up
    create_table :klasses_students, :id => false do |t|
      t.references :student
      t.references :klass

      t.timestamps
    end
  end

  def self.down
    drop_table :klasses_students
  end
end
