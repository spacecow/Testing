Given /^the following unit records?$/ do |table|
  table.hashes.each do |hash|
  	unit_hash = {}
  	hash.keys.map(&:to_sym).each do |key|
  		case
  			when key == :schedule
  				unit_hash[:schedule_id] = Schedule.first( :conditions=>[ "courses.name = ?", hash[:schedule] ], :include=>:course ).id
  			else
  				unit_hash[key] = hash[key]
  		end
  	end
  	Factory( :unit, unit_hash )
  end
end