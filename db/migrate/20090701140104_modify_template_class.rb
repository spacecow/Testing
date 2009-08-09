class ModifyTemplateClass < ActiveRecord::Migration
  def self.up
  	change_table :template_classes do |t|
  		t.change :capacity, :integer, :default=>0
  		t.change :inactive, :boolean, :default=>0
  		t.change :mail_sending, :integer, :limit=>1, :default=>0
  	end
  end

  def self.down
  	change_table :template_classes do |t|
  		t.change :capacity, :integer
  		t.change :inactive, :boolean
  		t.change :mail_sending, :integer, :limit=>1
  	end
  end
end