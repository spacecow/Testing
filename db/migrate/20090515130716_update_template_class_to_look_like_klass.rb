class UpdateTemplateClassToLookLikeKlass < ActiveRecord::Migration
  def self.up
    add_column :template_classes, :teacher_id, :integer
    add_column :template_classes, :classroom_id, :integer    
    add_column :template_classes, :capacity, :integer
    add_column :template_classes, :start_time, :time
    add_column :template_classes, :end_time, :time
    add_column :template_classes, :mail_sending, :integer, :limit=>1
  end

  def self.down
  	remove_column :template_classes, :teacher_id
  	remove_column :template_classes, :classroom_id
  	remove_column :template_classes, :capacity
  	remove_column :template_classes, :start_time
  	remove_column :template_classes, :end_time
  	remove_column :template_classes, :mail_sending
  end
end
