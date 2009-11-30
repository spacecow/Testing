class Event < ActiveRecord::Base
	has_many :registrants, :dependent => :destroy
	has_many :users, :through => :registrants
  has_many :comments

	attr_accessible :title_en, :title_ja, :date, :description_en, :description_ja
  
  validates_presence_of :title_en, :title_ja, :date
	validates_uniqueness_of :title_en, :title_ja
	
	def title( japanese )
		japanese ? title_ja : title_en
	end
	
	def description( japanese )
		japanese ? description_ja : description_en
	end
end
