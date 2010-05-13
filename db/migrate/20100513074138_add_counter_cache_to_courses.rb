class AddCounterCacheToCourses < ActiveRecord::Migration
  def self.up  
    add_column :courses, :klasses_count, 					:integer, :default=>0
    add_column :courses, :template_classes_count, :integer, :default=>0
      
		Course.reset_column_information
    Course.all.each do |c|
      Course.update_counters c.id, :klasses_count => c.klasses.count
      Course.update_counters c.id, :template_classes_count => c.template_classes.count
    end  
  end  
  
  def self.down  
    remove_column :courses, :klasses_count
    remove_column :courses, :template_classes_count
  end 
end
