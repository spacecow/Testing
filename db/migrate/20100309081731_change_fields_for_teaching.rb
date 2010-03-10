class ChangeFieldsForTeaching < ActiveRecord::Migration
  def self.up
  	remove_column :teachings, :course_id
  	add_column :teachings, :klass_id, :integer
		remove_column :teachings, :cost
		add_column :teachings, :cost, :integer
		remove_column :teachings, :note
		add_column :teachings, :status, :integer
		remove_column :klasses, :teacher_id
  end

  def self.down
  	remove_column :teachings, :klass_id
  	add_column :teachings, :course_id, :integer
  	remove_column :teachings, :cost
  	add_column :teachings, :cost, :integer, :default => 1500
  	add_column :teachings, :note, :text
  	remove_column :teachings, :status
  	add_column :klasses, :teacher_id, :integer
  end
end
