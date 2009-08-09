class ModifyKlass < ActiveRecord::Migration
  def self.up
  	change_table :klasses do |t|
  		t.change :capacity, :integer, :default=>0
  		t.change :cancel, :boolean, :default=>0
  		t.change :mail_sending, :integer, :limit=>1, :default=>0
  	end
  end

  def self.down
  	change_table :klasses do |t|
  		t.change :capacity, :integer
  		t.change :cancel, :boolean
  		t.change :mail_sending, :integer
  	end
  end
end