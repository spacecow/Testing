class ModifyCourse < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
  		t.change :inactive, :boolean, :default=>0
		end
  end

  def self.down
    change_table :courses do |t|
  		t.change :inactive, :boolean
		end  
  end
end
