class KanjisMeanings < ActiveRecord::Base
	validates_presence_of :kanji, :meaning
	belongs_to :kanji
	belongs_to :meaning
end
