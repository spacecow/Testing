class Setting < ActiveRecord::Base
	validates_uniqueness_of :name
	validates_presence_of :name
	
	def events_description( japanese )
		if japanese
			events_description_ja.blank? ? events_description_en : events_description_ja
		else
		  events_description_en.blank? ? events_description_ja : events_description_en
	  end
	end
	
	def todos_description( japanese )
		if japanese
			todos_description_ja.blank? ? todos_description_en : todos_description_ja
		else
			todos_description_en.blank? ? todos_description_ja : todos_description_en
		end
	end	
end

# == Schema Information
#
# Table name: settings
#
#  id                    :integer(4)      not null, primary key
#  name                  :string(255)
#  people_per_page       :integer(4)
#  units_per_schedule    :integer(4)
#  language              :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  events_description_en :text
#  events_description_ja :text
#  version               :string(255)
#  todos_description_en  :text
#  todos_description_ja  :text
#  subdomain             :string(255)
#

