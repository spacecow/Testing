class CreateTemplateClasses < ActiveRecord::Migration
  def self.up
    create_table :template_classes do |t|
      t.references :course
      t.references :course_time
      t.string :day
      t.string :title
      t.text :description
      t.boolean :inactive
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :template_classes
  end
end
