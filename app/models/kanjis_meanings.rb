class KanjisMeanings < ActiveRecord::Base
	validates_presence_of :kanji, :meaning
	belongs_to :kanji
	belongs_to :meaning
end

# == Schema Information
#
# Table name: kanjis_meanings
#
#  kanji_id   :integer(4)
#  meaning_id :integer(4)
#

