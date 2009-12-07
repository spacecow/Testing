class Meaning < ActiveRecord::Base
	has_and_belongs_to_many :kanjis
	validates_uniqueness_of :title
	validates_presence_of :title
end
