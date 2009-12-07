class KanjisKunyomis < ActiveRecord::Base
	validates_presence_of :kanji, :kunyomi
	belongs_to :kanji
	belongs_to :kunyomi
end
