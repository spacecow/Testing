class Kanji < ActiveRecord::Base
	has_and_belongs_to_many :meanings
	has_and_belongs_to_many :onyomis
	has_and_belongs_to_many :kunyomis
	validates_presence_of :title
end
