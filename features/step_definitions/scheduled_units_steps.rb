Given /^the following scheduled unit record$/ do |table|
  table.hashes.each do |hash|
  	unit_hash = {}
  	hash.keys.map(&:to_sym).each do |key|
  		case
  			when key == :unit_id
  				unit_hash[:schedule_id] = Schedule.first( :conditions=>[ "units.id = ?", hash[:unit_id] ], :include=>:units ).id
					unit_hash[:unit_id] = hash[:unit_id]
  			else
  				unit_hash[key] = hash[key]
  		end
  	end		
  	Factory( :scheduled_unit, unit_hash )
  end
end

When /^I should have ([0-9]+) scheduled units?$/ do |no|
  ScheduledUnit.count.should == no.to_i
end

When /^schedule "([^\"]*)" should have ([0-9]+) scheduled units?$/ do |name,no|
  Schedule.course( name ).first.scheduled_units.count.should == no.to_i
end