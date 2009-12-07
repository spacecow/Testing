class Kunyomi < ActiveRecord::Base
	has_and_belongs_to_many :kanjis
	validates_uniqueness_of :reading
	validates_presence_of :reading
end
