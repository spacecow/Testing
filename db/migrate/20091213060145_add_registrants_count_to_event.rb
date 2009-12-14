class AddRegistrantsCountToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :registrants_count, :integer, :default => 0
    Event.reset_column_information
    Event.all.each do |e|
  		e.update_attribute :registrants_count, e.registrants.length	
  	end
  end

  def self.down
    remove_column :events, :registrants_count
  end
end
