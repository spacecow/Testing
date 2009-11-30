class Setting < ActiveRecord::Base
	validates_uniqueness_of :name
	validates_presence_of :name
	
	def events_description( japanese )
		japanese ? events_description_ja : events_description_en
	end
end
